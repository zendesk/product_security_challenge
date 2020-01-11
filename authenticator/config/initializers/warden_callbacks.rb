Warden::Manager.after_authentication do |user, auth, _opts|
  event = LogStash::Event.new(
    message: "Successful login",
    uid: user.id,
    remote_ip: auth.request.ip
  ).as_json

  Rails.logger.info event
end

Warden::Manager.before_failure do |user, _auth, _opts|
  request = Rack::Request.new(user)

  if request.params["user"] && request.params["user"]["email"]
    email = request.params["user"]["email"].downcase.strip
    u = User.find_by_email(email)
  end

  if u
    msg = "Login failure"
    uid = u.id
  elsif email.present?
    msg = "Login failure: unknown account - #{email}"
  else
    msg = "Login failure: malformed request - missing email"
  end

  event = LogStash::Event.new(
    message: msg,
    uid: uid,
    remote_ip: request.ip
  ).as_json

  Rails.logger.info event
end
