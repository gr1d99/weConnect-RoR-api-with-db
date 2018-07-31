require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  context '.get' do
    before do
      create(:category)
    end

    let(:user) { create(:user) }
    let(:headers) { valid_headers }

    before do
      request.headers.merge!(headers)
      get :index
    end

    it { is_expected.to respond_with(200) }

    it 'returns expected categories' do
      categories = json['categories']
      expect(categories).not_to be(blank?)
      expect(categories.size).to eq(1)
    end
  end
end
