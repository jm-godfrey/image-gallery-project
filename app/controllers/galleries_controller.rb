class GalleriesController < ApplicationController
  load_and_authorize_resource except: :index

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]


  def index
    @galleries = current_user.galleries.where.not(id: nil)
    @gallery = current_user.galleries.build
  end

  def show
    # if @gallery.private? && (!user_signed_in? || @gallery.user != current_user)
    #   redirect_to galleries_path, alert: "You don't have access to that gallery."
    # end
    @photos = @gallery.photos
  end

  def create
    # @gallery = current_user.galleries.build(gallery_params)
    @gallery.user = current_user
    if @gallery.save
      redirect_to galleries_path, notice: "Gallery created successfully."
    else
      redirect_to galleries_path, alert: "Something went wrong."
    end
  end

  def edit
    redirect_to galleries_path, alert: "Not authorized." unless @gallery.user == current_user
  end

  def update
    # if @gallery.user == current_user
    if @gallery.update(gallery_params)
      redirect_to @gallery, notice: "Gallery updated."
    else
      render :edit
    end
    # else
    #   redirect_to galleries_path, alert: "Not authorized."
    # end
  end

  def destroy
    # if @gallery.user == current_user
    @gallery.destroy
    redirect_to galleries_path, notice: "Gallery deleted."
    # else
    # redirect_to galleries_path, alert: "Not authorized."
    # end
  end

  private

  # def set_gallery
  #   @gallery = Gallery.find(params[:id])
  # end

  def gallery_params
    params.require(:gallery).permit(:title, :description, :private)
  end
end
