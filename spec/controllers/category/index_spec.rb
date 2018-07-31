require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:business) { create(:business) }

  context '.get' do
    let(:user) { business.user }
    let(:headers) { valid_headers }

    before do
      request.headers.merge!(headers)
      get :index, params: { business_id: business.id }
    end

    it { is_expected.to respond_with(200) }

    it 'returns expected categories' do
      categories = json['categories']
      expect(categories).not_to be(blank?)
      expect(categories.size).to eq(1)
    end
  end
end
