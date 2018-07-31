require 'rails_helper'

RSpec.describe BusinessController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:business) { create(:business) }

  describe '#delete' do
    before do
      request.headers.merge!(headers)
    end

    describe '.destroy' do
      context 'when business exists' do
        before do
          delete :destroy, params: { id: business.id }
        end

        it { is_expected.to respond_with(200) }

        it 'returns success message' do
          expect(json['message']).to match(/Business deleted successfully/)
        end
      end

      context 'when business does not exist' do
        before do
          delete :destroy, params: { id: 12345 }
        end

        it { is_expected.to respond_with(404) }
      end
    end
  end
end
