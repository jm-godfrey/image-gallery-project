require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:gallery) { create(:gallery, user: user) }

  before { sign_in user }

  describe 'POST #create' do
    it 'creates a like for the gallery' do
      expect {
        post :create, params: { gallery_id: gallery.id }, format: :js
      }.to change(gallery.likes, :count).by(1)
    end

    it 'does not create duplicate likes from the same user' do
      gallery.likes.create(user: user)

      expect {
        post :create, params: { gallery_id: gallery.id }, format: :js
      }.not_to change(gallery.likes, :count)
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
    before { gallery.likes.create(user: user) }

    it 'removes the like' do
      expect {
        delete :destroy, params: { gallery_id: gallery.id }, format: :js
      }.to change(gallery.likes, :count).by(-1)
    end

    it 'does nothing if like does not exist' do
      gallery.likes.destroy_all

      expect {
        delete :destroy, params: { gallery_id: gallery.id }, format: :js
      }.not_to change(gallery.likes, :count)
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
