require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:business) { create(:business) }
  let(:user) { business.user }
  let(:headers) { valid_headers }
  let(:location_1) { Location.create!(address: Faker::Address.full_address) }
  let(:location_2) { Location.create!(address: Faker::Address.full_address) }

  describe '.get' do
    before do
      request.headers.merge!(headers)
    end

    context 'when locations exists' do
      before do
        business.locations << [location_1, location_2]
        get :index, params: { business_id: business.id }
      end

      it { is_expected.to respond_with(200) }

      it 'returns all locations' do
        expect(json['locations'].length).to eq(business.locations.count)
      end
    end
  end
end
