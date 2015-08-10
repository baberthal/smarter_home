require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#create" do
    let(:user) { build :user }

    it 'should be vaild with vaild attributes' do
      expect(user).to be_valid
    end

    it 'should be invalid without valid attributes' do
      user.email = nil
      expect(user).to_not be_valid
    end
  end

  describe "accessing services" do
    let(:user) { create :user_with_services }

    describe "User#services" do
      it 'returns the user services' do
        expect(user.services).to eq UserService.where(user_id: user.id)
      end

    end
  end
end
