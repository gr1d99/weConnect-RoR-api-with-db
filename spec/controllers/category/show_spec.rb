require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }

  before do
    request.headers.merge!(headers)
  end

  context 'when category exists' do

    let(:category) { create(:category) }

    before do
      get :show, params: { id: category.id }
    end

    it { is_expected.to respond_with(200) }

    it 'returns category details' do
      expect(json['category']).not_to be_nil
      expect(json['category']['id']).to eq(category.id)
    end
  end

  context 'when category does not exist' do
    before do
      get :show, params: { id: 234 }
    end

    it { is_expected.to respond_with(404) }
  end
end
