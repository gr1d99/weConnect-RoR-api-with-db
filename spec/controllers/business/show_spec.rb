require 'rails_helper'

RSpec.describe BusinessController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:business) { create(:business) }

  describe '.get /show' do
    before do
      request.headers.merge!(headers)
    end

    context 'when business exists' do
      before do
        get :show, params: { id: business.id }
      end

      it { is_expected.to respond_with(200) }

      it 'returns business details' do
        expect(json['business']).not_to be_nil
        expect(json['locations']).not_to be_nil
        expect(json['categories']).not_to be_nil
      end
    end

    context 'when business does not exist' do
      before do
        get :show, params: { id: 1098 }
      end

      it { is_expected.to respond_with(404) }
    end
  end
end
