require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "#email" do
    it "is persisted case-insensitive" do
      expect(User.find_by_email(user.email.upcase)).to eq user
    end
  end
end
