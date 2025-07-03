class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gallery, only: [:create, :destroy]

  def index
    @galleries = current_user.saved_galleries
  end

  def create
    @gallery.bookmarks.create(user: current_user)

    respond_to do |format|
      format.html { redirect_to @gallery }
      format.js
    end
  end

  def destroy
    @gallery.bookmarks.find_by(user: current_user)&.destroy

    respond_to do |format|
      format.html { redirect_to @gallery }
      format.js
    end
  end

  private

  def set_gallery
    @gallery = Gallery.find(params[:gallery_id])
  end
end
