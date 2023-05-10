class Admin::AdminController < ApplicationController

  def dashboard
    # @user = current_user
    authorize :admin
    @dashboard_sections = {
      "Mes logements" => {
        url: "admin_rooms",
        asset: "La Chambre.png"
      },
      "Réservations" => {
        url: "admin_bookings",
        asset: "admin/reserved.jpg"
      },
      "Créneaux disponibles" => {
        url: "admin_slots",
        asset: "admin/calendar.jpg"
      },
      "Conditions saisonnières" => {
        url: "admin_seasons",
        asset: "admin/seasons.jpg"
      },
      "Messages" => {
        url: "admin_messages",
        asset: "admin/letters.jpg"
      },
      "Utilisateurs" => {
        url: "admin_users",
        asset: "admin/people.jpg"
      }
    }
  end

  def slots
    authorize :admin
  end

  def seasons
    authorize :admin
  end

  def messages
    authorize :admin
  end
end
