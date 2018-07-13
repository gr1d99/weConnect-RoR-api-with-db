require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:headers) { valid_headers.except(:Authorization) }

  describe '.post /auth/login' do
    let(:user) { create(:user) }
    let(:valid_credentials) do
      {
          email: user.email,
          password: user.password
      }
    end

    let(:invalid_credentials) do
      {
          email: Faker::Internet.email,
          password: Faker::Internet.password
      }
    end

    context 'when request is valid' do
      before do
        post :login, params: valid_credentials
      end

      it 'returns authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when request is invalid' do
      before do
        post :login, params: invalid_credentials
      end

      it 'returns failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end
end
