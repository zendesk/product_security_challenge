class ApplicationController < ActionController::Base
  def append_info_to_payload(payload)
    super
    payload[:uid] = current_user.id if user_signed_in?
    payload[:remote_ip] = request.remote_ip
  end
end
