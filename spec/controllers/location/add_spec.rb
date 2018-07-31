require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:location) { create(:location) }

  before do
    request.headers.merge!(headers)
  end

  describe '.post' do
    context 'when all attributes are valid' do
      let(:valid_attributes) { attributes_for(:location) }

      before do
        post :create, params: valid_attributes
      end

      it { is_expected.to respond_with(201) }

      it 'returns success message' do
        expect(json['message']).to match(/Location created successfully/)
      end
    end

    context 'when attributes are not valid' do
      before do
        post :create, params: {}
      end

      it { is_expected.to respond_with(422) }

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Address can't be blank/)
      end
    end

    context 'when location exists' do
      before do
        post :create, params: {
          address: location.address
        }
      end

      it { is_expected.to respond_with(422) }

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Address has already been taken/)
      end
    end
  end
end
