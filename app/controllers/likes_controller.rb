class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gallery

  def create
    @gallery.likes.create(user: current_user)

    respond_to do |format|
      format.html { redirect_to @gallery }
      format.js
    end
  end

  def destroy
    @gallery.likes.find_by(user: current_user)&.destroy

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
