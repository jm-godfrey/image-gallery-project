class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gallery

  def create
    @gallery.likes.create(user: current_user)
    redirect_to @gallery
  end

  def destroy
    @gallery.likes.find_by(user: current_user)&.destroy
    redirect_to @gallery
  end

  private

  def set_gallery
    @gallery = Gallery.find(params[:gallery_id])
  end
end
