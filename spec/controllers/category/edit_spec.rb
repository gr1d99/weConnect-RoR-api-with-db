require 'rails_helper'

RSpec.describe CategoryController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  describe '#edit' do
    context 'when request is authenticated' do
      let(:user) { create(:user) }
      let(:headers) { valid_headers }
      let(:category) { create(:category) }
      let(:valid_attributes) { attributes_for(:category) }

      context 'when all attributes are provided' do
        before do
          request.headers.merge!(headers)
          post :update, params: { id: category.id }.merge!(valid_attributes)

        end

        it { is_expected.to respond_with(200) }

        it 'returns successful message' do
          expect(json['message']).to match(/Category updated successfully/)
        end
      end

      context 'when id param is invalid' do
        before do
          request.headers.merge!(headers)
          post :update, params: { id: 123456 }
        end

        it { is_expected.to respond_with(404) }

        it 'returns failure message' do
          expect(json['message']).to match(/Couldn't find Category with 'id'=123456/)
        end
      end
    end

    context 'when request is not authenticated' do
      before do
        post :update, params: { id: 123456 }
      end

      it { is_expected.to respond_with(422) }
    end
  end
end
