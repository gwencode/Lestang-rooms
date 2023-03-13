class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[localisation contact]

  def localisation
    @markers = [ { lat: 43.667737, lng: 1.501558 } ]
  end

  def contact
  end
end
