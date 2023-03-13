class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[localisation contact]

  def localisation
  end

  def contact
  end
end
