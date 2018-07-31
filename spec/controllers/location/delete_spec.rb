require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }

  describe '.delete' do
    let(:business) { create(:business) }
    let(:location) { business.locations.last }

    before do
      request.headers.merge!(headers)
    end

    context 'when location exists' do
      before do
        delete :destroy, params: {
          business_id: business.id,
          id: location.id
        }
      end

      it { is_expected.to respond_with(200) }

      it 'returns success message' do
        expect(json['message']).to eq(Message.location_deleted)
      end
    end

    context 'when location does not exist' do
      before do
        delete :destroy, params: {
          business_id: business.id,
          id: 67890
        }
      end

      it { is_expected.to respond_with(404) }
    end
  end
end
