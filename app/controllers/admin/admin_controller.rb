class Admin::AdminController < ApplicationController

  def dashboard
    # @user = current_user
    authorize :admin
  end

  def slots
    authorize :admin
  end

  def messages
    authorize :admin
  end
end
