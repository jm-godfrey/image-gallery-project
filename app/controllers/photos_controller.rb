class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gallery

  def create
    @photo = @gallery.photos.build(photo_params)
    if @photo.save
      @photo.image.variant(:thumbnail).processed
      redirect_to @gallery, notice: "Photo uploaded."
    else
      redirect_to @gallery, alert: "Upload failed."
    end
  end

  def destroy
    @photo = @gallery.photos.find(params[:id])
    @photo.destroy
    redirect_to @gallery, notice: "Photo deleted."
  end

  private

  def set_gallery
    @gallery = current_user.galleries.find(params[:gallery_id])
  end

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end
