require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }
  let(:header) { { Authorization: token_generator(user.email) } }
  subject(:invalid_request_object) { described_class.new({}) }
  subject(:valid_request_object) { described_class.new(header) }

  describe '#call' do
    context 'when valid request' do
      it 'returns user object' do
        result = valid_request_object.call
        expect(result[:user]).to eq(user)
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        it 'raises MissingTokenError' do
          expect { invalid_request_object.call }
            .to raise_error(
                  ExceptionHandler::MissingToken, 'Missing token.'
                )
        end
      end
    end

    context 'when invalid token' do
      subject(:invalid_request_object) do
        described_class.new(Authorization: token_generator(5))
      end

      it 'raises InvalidToken error' do
        expect { invalid_request_object.call }
          .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
      end
    end

    context 'when token is expired' do
      let(:header) { { Authorization: expired_token_generator(user.email) } }
      subject(:request_object) { described_class.new(header) }

      it 'raises ExceptionHandle::ExpiredSignature error' do
        expect { request_object.call }
          .to raise_error(
            ExceptionHandler::InvalidToken, /Signature has expired/
          )
      end
    end

    context 'fake token' do
      let(:header) { { Authorization: 'foobar' } }
      subject(:invalid_request_object) { described_class.new(header) }

      it 'handles JWT::DecodeToken error' do
        expect { invalid_request_object.call }
          .to raise_error(
            ExceptionHandler::InvalidToken, /Not enough or too many segments/
          )
      end
    end
  end
end
