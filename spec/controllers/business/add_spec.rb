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
        post :create, params: {
          location_id: business_params[:locations][0].id,
          category_id: business_params[:categories][0].id
        }.merge!(business_params)
      end

      it { is_expected.to respond_with(201) }

      it 'returns success message' do
        expect(json['message']).to match(/Business successfully created/)
      end
    end

    describe 'when some params are missing' do
      context 'when location_id is missing' do
        before do
          post :create, params: {
            category_id: business_params[:categories][0].id
          }.merge!(business_params)
        end

        it { is_expected.to respond_with(404) }
      end

      context 'when category_id is missing' do
        before do
          post :create, params: {
          }.merge!(business_params)
        end

        it { is_expected.to respond_with(404) }
      end
    end
  end
end
