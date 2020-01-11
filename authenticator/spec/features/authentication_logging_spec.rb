require "rails_helper"

feature "Authentication logging", type: :feature do
  let(:user) { create(:user) }

  before do
    allow(Rails.logger).to receive(:info)
  end

  context "on authentication" do
    it "logs the login" do
      expect(Rails.logger).to receive(:info).with(hash_including(
        "message" => "Successful login",
        "uid" => user.id,
        "remote_ip" => "127.0.0.1"
      ))

      visit "/users/sign_in"
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_on "Log in"
    end
  end

  context "on failed login" do
    it "logs the attempt with user id" do
      expect(Rails.logger).to receive(:info).with(hash_including(
        "message" => "Login failure",
        "uid" => user.id,
        "remote_ip" => "127.0.0.1"
      ))

      visit "/users/sign_in"
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: "bogu5"
      click_on "Log in"
    end
  end

  context "on failed login with unknown account" do
    it "logs the attempt with email" do
      expect(Rails.logger).to receive(:info).with(hash_including(
        "message" => "Login failure: unknown account - bogu5@example.com",
        "remote_ip" => "127.0.0.1"
      ))

      visit "/users/sign_in"
      fill_in "user[email]", with: "bogu5@example.com"
      fill_in "user[password]", with: "bogu5"
      click_on "Log in"
    end
  end

  context "on login without email" do
    it "logs the attempt" do
      expect(Rails.logger).to receive(:info).with(hash_including(
        "message" => "Login failure: malformed request - missing email",
        "remote_ip" => "127.0.0.1"
      ))

      visit "/users/sign_in"
      click_on "Log in"
    end
  end
end