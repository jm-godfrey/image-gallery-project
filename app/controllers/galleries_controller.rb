class GalleriesController < ApplicationController
  load_and_authorize_resource except: :index

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index]


  def index
    # doesn't use cancancan to generate galleries as it's only galleries owned by the user
    @galleries = current_user.galleries.where.not(id: nil)
    @gallery = current_user.galleries.build
  end

  def show
    @photos = @gallery.photos
  end

  def create
    @gallery.user = current_user
    if @gallery.save
      redirect_to galleries_path, notice: "Gallery created successfully."
    else
      redirect_to galleries_path, alert: "Something went wrong."
    end
  end

  def update
    if @gallery.update(gallery_params)
      redirect_to @gallery, notice: "Gallery updated."
    else
      redirect_to @gallery, alert: "Something went wrong"
    end
  end

  def destroy
    @gallery.destroy
    redirect_to galleries_path, notice: "Gallery deleted."
  end

  def search
    @query = params[:query]
    if @query.present?
      @galleries = Gallery.where("title ILIKE ?", "%#{@query}%")
    else
      @galleries = Gallery.none
    end
  end

  private

  def gallery_params
    params.require(:gallery).permit(:title, :description, :private)
  end
end
