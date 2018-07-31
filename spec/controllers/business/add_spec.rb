require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:business_params) { attributes_for(:business) }

  describe '.post' do
    before do
      request.headers.merge!(headers)
    end

    context 'when all attributes are given' do
      before do
        post :create, params: business_params
      end

      it { is_expected.to respond_with(201) }

      it 'returns success message' do
        expect(json['message']).to match(/Business successfully created/)
      end
    end

    context 'when name is missing' do
      before do
        post :create, params: {}
      end

      it { is_expected.to respond_with(422) }

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end
end
