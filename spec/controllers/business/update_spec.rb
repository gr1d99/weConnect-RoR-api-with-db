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

    context 'update location' do
      let(:location) { create(:location, address: Faker::Address.full_address) }

      before do
        put :update, params: {
          id: business.id,
          location_id: location.id
        }
      end

      it { is_expected.to respond_with(200) }

      it 'is returns success message' do
        expect(json['message']).to match(/Business updated successfully/)
      end
    end

    context 'update category' do
      let(:category) { create(:category, name: Faker::Company.name) }

      before do
        put :update, params: {
          id: business.id,
          category_id: category.id
        }
      end

      it { is_expected.to respond_with(200) }

      it 'is returns success message' do
        expect(json['message']).to match(/Business updated successfully/)
      end
    end
  end
end
