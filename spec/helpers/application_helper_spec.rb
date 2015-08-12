require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "bootstrap_class_for" do
    context 'with predefined bootstrap classes' do
      before :each do
        @expected = [
          {
            flash_type: "success",
            expected_class: "alert-success"
          },
          {
            flash_type: "error",
            expected_class: "alert-error"
          },
          {
            flash_type: "alert",
            expected_class: "alert-block"
          },
          {
            flash_type: "notice",
            expected_class: "alert-info"
          }
        ]
      end

      it 'gives the proper class for the flash_type' do
        @expected.each do |ex|
          expect(bootstrap_class_for(ex[:flash_type])).to eq ex[:expected_class]
        end
      end
    end

    context 'without a predefined bootstrap class' do
      it 'stringifies the flash type if it is a symbol' do
        expect(bootstrap_class_for :something_else).to eq "something_else"
      end

      it 'passes the name through if it is a string' do
        expect(bootstrap_class_for "another").to eq "another"
      end
    end
  end

  describe "short_name_for" do
    it 'returns the short name of a provider' do
      expect(short_name_for OmniAuth::Strategies::Nest).to eq "Nest"
    end
  end

  describe "omniauth_link_for" do
    let(:request) { controller.request }
    it 'returns the proper link' do
      expect(omniauth_link_for(OmniAuth::Strategies::Nest)).to match /Nest/
    end
  end

end
