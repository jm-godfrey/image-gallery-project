class PagesController < ApplicationController

  def home
    @galleries = Gallery.accessible_by(current_ability, :read)
  end

end