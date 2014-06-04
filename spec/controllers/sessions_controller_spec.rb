require 'spec_helper'

describe SessionsController do 
  describe "GET new" do
    it "redirects to home page if signed in" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
     
    end
    it "renders new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    context "with valid credentials" do 
      before do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
      end
      it "puts the signed in user in the session" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(session[:user_id]).to eq(alice.id)
      end
      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end
      it "sets the notice" do
        expect(flash[:notice]).not_to be_blank
      end
    end
    context "with invalid credentials" do 
      before do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + 'asdgfgfdg'
      end
      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to be_blank
      end
      it "redirects to the sign in page" do 
        expect(response).to redirect_to sign_in_path
      end
      it "sets the error message" do
        expect(flash[:error]).not_to be_blank
      end
    end
  end
  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end  
    it "clears the session" do
      expect(session[:user_id]).to be_nil
    end
    it "redirects to sign in page/root path" do
      expect(response).to redirect_to root_path
    end
    it "sets the notice" do
      expect(flash[:notice]).not_to be_blank
    end
  end
end