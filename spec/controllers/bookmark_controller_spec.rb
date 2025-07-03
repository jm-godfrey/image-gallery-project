require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  let(:user) { create(:user) }
  let(:gallery) { create(:gallery, user: create(:user)) } # someone else's gallery

  before { sign_in user }

  describe 'GET #index' do
    it 'assigns the user’s saved galleries' do
      saved_gallery = create(:gallery)
      create(:bookmark, user: user, gallery: saved_gallery)

      get :index
      expect(assigns(:galleries)).to include(saved_gallery)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    it 'creates a bookmark for the gallery' do
      expect {
        post :create, params: { gallery_id: gallery.id }, format: :js
      }.to change(gallery.bookmarks, :count).by(1)
    end

    it 'does not create duplicate bookmarks' do
      gallery.bookmarks.create(user: user)

      expect {
        post :create, params: { gallery_id: gallery.id }, format: :js
      }.not_to change(gallery.bookmarks, :count)
    end

    it 'redirects to the gallery on HTML request' do
      post :create, params: { gallery_id: gallery.id }, format: :html
      expect(response).to redirect_to(gallery)
    end

    it 'renders JS response' do
      post :create, params: { gallery_id: gallery.id }, format: :js
      expect(response.content_type).to eq 'text/javascript; charset=utf-8'
    end
  end

  describe 'DELETE #destroy' do
    before { gallery.bookmarks.create(user: user) }

    it 'removes the bookmark' do
      expect {
        delete :destroy, params: { gallery_id: gallery.id }, format: :js
      }.to change(gallery.bookmarks, :count).by(-1)
    end

    it 'does nothing if bookmark does not exist' do
      gallery.bookmarks.destroy_all

      expect {
        delete :destroy, params: { gallery_id: gallery.id }, format: :js
      }.not_to change(gallery.bookmarks, :count)
    end

    it 'redirects to the gallery on HTML request' do
      delete :destroy, params: { gallery_id: gallery.id }, format: :html
      expect(response).to redirect_to(gallery)
    end

    it 'renders JS response' do
      delete :destroy, params: { gallery_id: gallery.id }, format: :js
      expect(response.content_type).to eq 'text/javascript; charset=utf-8'
    end
  end
end
