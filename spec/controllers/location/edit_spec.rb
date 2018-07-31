require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:location) { create(:location) }

  describe '.put' do
    before do
      request.headers.merge!(headers)
    end

    context 'when request is valid' do
      before do
        put :update, params: { id: location.id, address: Faker::Address.full_address }
      end
      it { is_expected.to respond_with(200) }

      it 'does not delete or add any record' do
        expect { request }.not_to change(Location, :count)
      end

      it 'returns success message' do
        expect(json['message']).to eq(Message.location_updated)
      end
    end

    context 'when there is no change' do
      before do
        put :update, params: { id: location.id, address: location.address }
      end

      it 'returns no changes' do
        expect(json['message']).to eq(Message.location_not_changed)
      end
    end

    context 'when no attributes are provided' do
      before do
        put :update, params: { id: location.id }
      end
      it 'returns no change made' do
        expect(json['message']).to eq(Message.location_not_changed)
      end
    end

    context 'when location does not exist' do
      before do
        put :update, params: { id: 1000 }
      end

      it { is_expected.to respond_with(404) }
    end
  end
end
