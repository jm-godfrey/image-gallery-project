require 'rails_helper'

RSpec.describe GalleriesController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:gallery) { create(:gallery, user: user) }
  let(:valid_attributes) { { title: "Test", description: "Desc", private: false } }

  describe "GET #index" do
    context "when signed in" do
      before { sign_in user }

      it "assigns user's galleries to @galleries" do
        gallery
        get :index
        expect(assigns(:galleries)).to include(gallery)
      end
    end

    context "when not signed in" do
      it "redirects to login" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show" do
    context "when gallery is public" do
      it "shows the gallery" do
        gallery.update(private: false)
        get :show, params: { id: gallery.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "when gallery is private and user is owner" do
      before { sign_in user }

      it "shows the gallery" do
        get :show, params: { id: gallery.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "when gallery is private and user is not owner" do
      before do
        gallery.update(private: true)
        sign_in other_user
      end

      it "raises CanCan::AccessDenied" do
        expect {
          get :show, params: { id: gallery.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe "POST #create" do
    before { sign_in user }

    it "creates a new gallery" do
      expect {
        post :create, params: { gallery: valid_attributes }
      }.to change(Gallery, :count).by(1)
    end

    it "assigns the gallery to the current user" do
      post :create, params: { gallery: valid_attributes }
      expect(Gallery.last.user).to eq(user)
    end
  end

  describe "PATCH #update" do
    before { sign_in user }

    it "updates the gallery title" do
      patch :update, params: { id: gallery.id, gallery: { title: "Updated" } }
      expect(gallery.reload.title).to eq("Updated")
    end
  end

  describe "DELETE #destroy" do
    before do
      sign_in user
      gallery # trigger creation
    end

    it "deletes the gallery" do
      expect {
        delete :destroy, params: { id: gallery.id }
      }.to change(Gallery, :count).by(-1)
    end
  end

  describe "authorization checks" do
    before { sign_in other_user }

    it "denies access to edit another user's gallery" do
      expect {
        get :edit, params: { id: gallery.id }
      }.to raise_error(CanCan::AccessDenied)
    end
  end
end