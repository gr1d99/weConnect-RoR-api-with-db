require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  describe 'when request is authenticated' do
    let(:business) { create(:business) }
    let(:user) { business.user }
    let(:headers) { valid_headers }
    let(:category) { business.categories.last }

    before do
      request.headers.merge!(headers)
    end

    context 'when id exists' do
      before do
        delete :destroy, params: {
          business_id: business.id,
          id: category.id
        }
      end

      it { is_expected.to respond_with(200) }

      it 'returns success message' do
        expect(json['message']).to match(/Category deleted successfully/)
      end
    end

    context 'when id does not exist' do
      before do
        delete :destroy, params: {
          business_id: business.id,
          id: 'jhgf1234'
        }
      end

      it { is_expected.to respond_with(404) }
    end
  end
end
