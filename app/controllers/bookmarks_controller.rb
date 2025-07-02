class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gallery, only: [:create, :destroy]

  def index
    @galleries = current_user.saved_galleries
  end

  def create
    @gallery.bookmarks.create(user: current_user)
    redirect_to @gallery
  end

  def destroy
    @gallery.bookmarks.find_by(user: current_user)&.destroy
    redirect_to @gallery
  end

  private

  def set_gallery
    @gallery = Gallery.find(params[:gallery_id])
  end
end
