require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  describe '.get' do
    context 'when business exists' do
      let(:business) { create(:business) }
      let(:user) { business.user }
      let(:headers) { valid_headers }

      before do
        request.headers.merge!(headers)
        get :index
      end

      it { is_expected.to respond_with(200) }

      it 'returns an array of businesses' do
        expect(json['businesses'].length)
          .to eq(1)
      end
    end

    context 'when business does not exist' do
      let(:user) { create(:user) }
      let(:headers) { valid_headers }

      before do
        request.headers.merge!(headers)
        get :index
      end

      it 'returns an empty array' do
        expect(json['businesses']).to eq([])
      end
    end
  end
end
