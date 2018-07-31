require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:business) { create(:business) }

  describe '.update /business/update/[id]' do
    before do
      request.headers.merge!(headers)
    end

    context 'update name' do
      before do
        put :update, params: {
          id: business.id,
          name: 'New Name'
        }
      end

      it { is_expected.to respond_with(200) }

      it 'returns success message' do
        expect(json['message']).to match(/Business updated successfully/)
      end
    end
  end
end
