class PagesController < ApplicationController
  def home
    redirect_to categories_path unless current_user.nil?
  end

  def sign_up
  end
end
