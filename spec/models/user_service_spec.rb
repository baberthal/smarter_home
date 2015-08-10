require 'rails_helper'

RSpec.describe UserService, type: :model do

  describe "#create" do
    context 'without credentails supplied' do
      let(:user_service) { build(:user_service) }
      it 'should be invalid without valid attributes' do
        user_service.user_id = nil
        expect(user_service).to_not be_valid
      end

      it 'should be vaild with valid attributes' do
        user_service.user_id ||= 1
        expect(user_service).to be_valid
      end
    end

    context 'with credentails supplied' do
      let(:user_service) { build(:user_service_with_credentials) }
      it 'should serialize the credentails attribute' do
        expect(user_service.credentials).to be_a Hash
      end
    end
  end
end
