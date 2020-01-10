require "rails_helper"

feature "User authentication", type: :feature do
  let(:user) { create(:user) }

  context "when unauthenticated" do
    scenario "user is unable to access the dashboard" do
      visit "/"
      expect(page).to have_current_path("/users/sign_in")
      expect(page).to have_text "You need to sign in or sign up before continuing."
    end
  end

  context "when authenticated" do
    before do
      visit "/users/sign_in"
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_on "Log in"
    end

    scenario "user is able to access the dashboard" do
      expect(page).to have_current_path("/")
      expect(page).to have_text "Signed in successfully."
    end
  end
end
