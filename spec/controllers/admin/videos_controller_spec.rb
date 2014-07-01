require 'spec_helper'

describe Admin::VideosController do 
  describe "GET new" do 
    it_behaves_like "requires sign in" do 
      let(:action) { get :new }
    end

    it_behaves_like "requires admin" do 
       let(:action) { post :create }
    end

    it "sets the @video to a new video" do 
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of Video 
      expect(assigns(:video)).to be_new_record
    end

    it "redirects the regular user to the home path" do 
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end

    it "sets the flash error message for regular user" do 
      set_current_user
      get :new
      expect(flash[:error]).to be_present
    end
  end

  describe "POST create" do 
    it_behaves_like "requires sign in" do 
      let(:action) { post :create }
    end
    it_behaves_like "requires admin" do 
      let(:action) { post :create }
    end

    context "with valid input" do 
      it "redirects to the add new video page" do 
        set_current_admin
        category = Fabricate(:category, name: 'category', created_at: '2014-06-10 18:45:45', updated_at: '2014-06-10 18:45:45')
        post :create, video: { title: "Monk", category_id: category.id, description: "good show" }
        expect(response).to redirect_to new_admin_video_path
      end

      it "creates a video" do 
        set_current_admin
        category = Fabricate(:category, name: 'category', created_at: '2014-06-10 18:45:45', updated_at: '2014-06-10 18:45:45')
        post :create, video: { title: "Monk", category_id: category.id, description: "good show" }
        expect(category.videos.count).to eq(1) 
      end

      it "sets the flash success message" do 
        set_current_admin
        category = Fabricate(:category, name: 'category', created_at: '2014-06-10 18:45:45', updated_at: '2014-06-10 18:45:45')
        post :create, video: { title: "Monk", category_id: category.id, description: "good show" }
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do 
      it "does not create a video" do 
        set_current_admin
        category = Fabricate(:category, name: 'category', created_at: '2014-06-10 18:45:45', updated_at: '2014-06-10 18:45:45')
        post :create, video: { category_id: category.id, description: "good show" }
        expect(category.videos.count).to eq(0)
      end

      it "renders the :new template" do 
        set_current_admin
        category = Fabricate(:category, name: 'category', created_at: '2014-06-10 18:45:45', updated_at: '2014-06-10 18:45:45')
        post :create, video: { category_id: category.id, description: "good show" }
        expect(response).to render_template :new 
      end

      it "sets the @video variable" do 
        set_current_admin
        category = Fabricate(:category, name: 'category', created_at: '2014-06-10 18:45:45', updated_at: '2014-06-10 18:45:45')
        post :create, video: { category_id: category.id, description: "good show" }
        expect(assigns(:video)).to be_present
      end

      it "sets the flash error message" do 
        set_current_admin
        category = Fabricate(:category, name: 'category', created_at: '2014-06-10 18:45:45', updated_at: '2014-06-10 18:45:45')
        post :create, video: { category_id: category.id, description: "good show" }
        expect(flash[:error]).to be_present
      end
    end
  end
end