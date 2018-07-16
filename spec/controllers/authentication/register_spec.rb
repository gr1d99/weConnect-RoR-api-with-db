require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:headers) { valid_headers.except(:Authorization) }

  describe 'post /auth/register' do
    let(:user) { build(:user) }
    let(:valid_attributes) do
      attributes_for(:user, password_confirmation: user.password)
    end

    context 'when request is valid' do
      before do
        post :register, params: valid_attributes
      end

      it { is_expected.to respond_with(201) }

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before do
        post :register, params: {}
      end

      it { is_expected.to respond_with(422) }

      it 'returns failure message' do
        expect(json['message'])
          .to match(
            /Validation failed: Password can't be blank, Email can't be blank/
          )
      end
    end
  end
end
