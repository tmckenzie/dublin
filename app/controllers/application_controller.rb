class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  before_filter :set_timezone


  def set_timezone
    Time.zone = current_user.time_zone
  end
end
