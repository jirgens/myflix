require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  describe "POST create" do
    context "with valid input" do
      before {post :create, user: Fabricate.attributes_for(:user)}
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      it "should redirect to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with invalid input" do
      before {post :create, user: {password: "passowrd", full_name: "Kevin Wang"}}
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context "sending welcome email" do 
      after { ActionMailer::Base.deliveries.clear }
      it "sends a welcome email to new user with valid inputs" do 
        post :create, user: { email: "joe@example.com", password: "passowrd", full_name: "Joe Schmoe" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@example.com'])
      end

      it "sends a welcome email containing user name with valid inputs" do 
        post :create, user: { email: "joe@example.com", password: "passowrd", full_name: "Joe Schmoe" }
        expect(ActionMailer::Base.deliveries.last.body).to include("Joe Schmoe")
      end

      it "does not send email with invalid inputs" do 
        post :create, user: { email: "joe@example.com", password: "passowrd" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe "GET show" do
    it_behaves_like "requires sign in" do 
      let(:action) {get :show, id: 3}
    end

    it "sets @user" do 
      set_current_user
      alice = Fabricate(:user)
      get :show, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
  end
end