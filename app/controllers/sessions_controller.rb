class SessionsController < Devise::SessionsController
  skip_before_filter :set_timezone
end