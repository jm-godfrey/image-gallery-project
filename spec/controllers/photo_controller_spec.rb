require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:gallery) { create(:gallery, user: user) }
  let(:image) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png') }
  let(:text_file) do
    fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'text.txt'), 'text/plain')
  end

  before { sign_in user }

  describe 'POST #create' do
    context 'with valid image' do
      it 'creates a new photo' do
        expect {
          post :create, params: {
            gallery_id: gallery.id,
            photo: { image: image }
          }
        }.to change(Photo, :count).by(1)

        expect(response).to redirect_to(gallery_path(gallery))
        expect(flash[:notice]).to eq("Photo uploaded.")
      end
    end

    context 'with invalid image' do
      it 'does not create photo and redirects' do
        expect {
          post :create, params: {
            gallery_id: gallery.id,
            photo: { image: text_file }
          }
        }.not_to change(Photo, :count)

        expect(response).to redirect_to(gallery_path(gallery))
        expect(flash[:alert]).to eq("Upload failed.")
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the photo' do
      post :create, params: {
            gallery_id: gallery.id,
            photo: { image: image }
          }
      
      photo = gallery.photos.last
      expect(photo).to be_present
      
      expect {
        delete :destroy, params: { gallery_id: gallery.id, id: photo.id }
      }.to change(Photo, :count).by(-1)

      expect(response).to redirect_to(gallery_path(gallery))
      expect(flash[:notice]).to eq("Photo deleted.")
    end
  end
end
