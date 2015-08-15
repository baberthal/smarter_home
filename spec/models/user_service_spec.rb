require 'rails_helper'

RSpec.describe UserService, type: :model do
  describe '#create' do
    context 'without credentails supplied' do
      let(:user_service) { build(:user_service) }
      it 'is invalid without valid attributes' do
        user_service.user_id = nil
        expect(user_service).to_not be_valid
      end

      it 'is vaild with valid attributes' do
        user_service.user_id ||= 1
        expect(user_service).to be_valid
      end
    end

    context 'with credentails supplied' do
      let(:user_service) { build(:user_service_with_credentials) }
      it 'serializes the credentails attribute' do
        expect(user_service.credentials).to be_a Hash
      end
    end
  end

  describe '#image' do
    let(:image_files) do
      Dir[Rails.root.join('app', 'assets', 'images', '**')].map do |f|
        File.basename(f)
      end
    end

    let(:providers) { [] }

    before :each do
      %w( nest trakt ).each do |provider|
        providers << create(:user_service, service: provider)
      end
    end

    it 'returns the correct image based on the provider' do
      providers.each do |prov|
        expect(image_files).to include prov.image
      end
    end
  end
end
