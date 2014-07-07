require 'spec_helper'

describe UserSignup do
  describe "#sign_up" do
    context "valid personal info and valid card" do 
      let(:charge) { double(:charge, successful?: true) }

      before do 
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end

      after do
        ActionMailer::Base.deliveries.clear 
      end

      it "creates the user" do
        UserSignup.new(Fabricate.build(:user)).sign_up("some_stripe_token", nil)
        expect(User.count).to eq(1)
      end

      it "sends a welcome email to new user with valid inputs" do 
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com')).sign_up('some_stripe_token', nil)
        expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@example.com'])
      end

      it "sends a welcome email containing user name with valid inputs" do 
        UserSignup.new(Fabricate.build(:user, full_name: 'Joe Schmoe', email: 'joe@example.com')).sign_up('some_stripe_token', nil)
        expect(ActionMailer::Base.deliveries.last.body).to include("Joe Schmoe")
      end

      it "makes the user follow the inviter" do 
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).sign_up("some_stripe_token", invitation.token)
        joe = User.where(email: 'joe@example.com').first
        expect(joe.follows?(alice)).to be_true
      end

      it "makes the inviter follow the user" do 
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).sign_up("some_stripe_token", invitation.token)
        joe = User.where(email: 'joe@example.com').first
        expect(alice.follows?(joe)).to be_true
      end


      it "expires the invitation token upon acceptance" do 
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).sign_up("some_stripe_token", invitation.token)
        expect(Invitation.first.token).to be_nil
      end
    end

    context "with invalid personal info" do  #######
      it "does not create the user" do
        UserSignup.new(User.new(email: 'kevin@example.com')).sign_up('1231241', nil)
        expect(User.count).to eq(0)
      end

      it "does not charge the card" do
        StripeWrapper::Charge.should_not_receive(:create)
        UserSignup.new(User.new(email: 'kevin@example.com')).sign_up('1231241', nil)
      end

      it "does not send email with invalid inputs" do 
        UserSignup.new(User.new(email: 'joe@example.com', password: 'password')).sign_up('1231241', nil)
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    context "with valid personal info and declined card" do 
      it "does not create the user" do
        charge = double(:charge, successful?: false, error_message: "There was a problem with your card.")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        UserSignup.new(Fabricate.build(:user)).sign_up('1231241', nil)
        expect(User.count).to eq(0)
      end
    end

  end
end