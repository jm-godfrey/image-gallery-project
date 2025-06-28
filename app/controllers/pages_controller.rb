class PagesController < ApplicationController

  def home
    if user_signed_in?
      @galleries = Gallery.where("private = ? OR user_id = ?", false, current_user.id)
    else
      @galleries = Gallery.where(private: false)
    end
  end

end