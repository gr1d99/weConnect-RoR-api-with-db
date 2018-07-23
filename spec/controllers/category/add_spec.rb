require 'rails_helper'

RSpec.describe CategoryController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  describe '#POST .create' do
    let(:category_attributes) { attributes_for(:category) }

    context 'when request is not authenticated' do
      before do
        post :create, params: category_attributes
      end

      it { is_expected.to respond_with(422) }

      it 'returns success message' do
        expect(json['message']).to match(/Missing token/)
      end
    end

    describe 'when request is authenticated' do
      let(:user) { create(:user) }
      let(:headers) { valid_headers }

      before do
        request.headers.merge!(headers)
      end

      context 'params are valid' do
        before do
          post :create, params: category_attributes
        end

        it { is_expected.to respond_with(201) }

        it 'returns success message' do
          expect(json['message']).to match(/Category created successfully/)
        end

        context 'when name is duplicated' do
          before do
            post :create, params: category_attributes
          end

          it 'returns failure message' do
            expect(json['message'])
              .to match(/Validation failed: Name has already been taken/)
          end
        end

      end

      context 'params are invalid' do
        before { post :create, params: {} }

        it { is_expected.to respond_with(422) }

        it 'returns failure message' do
          expect(json['message'])
            .to match(/Validation failed: Name can't be blank/)
        end
      end
    end
  end
end