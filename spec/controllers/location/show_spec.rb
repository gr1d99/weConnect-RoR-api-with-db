require 'rails_helper'

RSpec.describe LocationController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:location_1) { create(:location) }
  let(:location_2) { create(:location) }

  describe '.get' do
    before do
      request.headers.merge!(headers)
    end

    context 'when location exists' do
      before do
        get :show, params: { id: location_1.id }
      end

      it { is_expected.to respond_with(200) }

      it 'returns location details' do
        expect(json['location']).not_to be_nil
      end
    end

    context 'when location does not exist' do
      before do
        get :show, params: { id: 345 }
      end

      it { is_expected.to respond_with(404) }
    end
  end
end
