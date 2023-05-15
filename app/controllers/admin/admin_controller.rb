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
      },
      "Avis" => {
        url: "admin_reviews",
        asset: "admin/reviews.jpg"
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

    chatrooms_with_messages = policy_scope(Chatroom).joins(:messages).order('messages.created_at DESC').uniq
    chatrooms_without_messages = policy_scope(Chatroom).left_outer_joins(:messages).where(messages: { id: nil }).order(created_at: :desc)

    @chatrooms = chatrooms_with_messages.union(chatrooms_without_messages)
  end
end
