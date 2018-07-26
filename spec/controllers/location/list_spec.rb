require 'rails_helper'

RSpec.describe LocationController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }

  describe '.get' do
    before do
      request.headers.merge!(headers)
    end

    context 'when locations exists' do
      before do
        Location.create!(address: Faker::Address.full_address)
        Location.create!(address: Faker::Address.full_address)

        get :index
      end

      it { is_expected.to respond_with(200) }

      it 'returns all locations' do
        expect(json['locations'].length).to eq(Location.count)
      end
    end

    context 'when there are no locations' do
      before do
        get :index
      end

      it 'returns an empty array' do
        expect(json['locations']).to be_a_kind_of(Array)
        expect(json['locations'].length).to eq(0)
      end
    end
  end
end
