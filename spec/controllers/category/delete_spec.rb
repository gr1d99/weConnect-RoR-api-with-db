require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  describe 'when request is authenticated' do
    let(:user) { create(:user) }
    let(:headers) { valid_headers }
    let(:category) { create(:category) }

    before do
      request.headers.merge!(headers)
    end

    context 'when id exists' do
      before do
        delete :destroy, params: { id: category.id }
      end

      it { is_expected.to respond_with(200) }

      it 'returns success message' do
        expect(json['message']).to match(/Category deleted successfully/)
      end
    end

    context 'when id does not exist' do
      before do
        delete :destroy, params: { id: 'jhgf1234' }
      end

      it { is_expected.to respond_with(404) }
    end
  end
end
