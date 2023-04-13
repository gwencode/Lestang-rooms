class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[localisation contact]

  def localisation
    @markers = [
      { lat: 43.671038,
        lng: 1.497738,
        info_window_html: render_to_string(partial: "info_window"),
        marker_html: render_to_string(partial: "marker")
        }
      ]
  end

  def contact
  end
end
