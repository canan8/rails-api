require 'rails_helper'

RSpec.describe UserAuthenticator do
  describe '#perform' do
    let(:authenticator) { described_class.new('some_code') }

    subject { authenticator.perform }
    
    context 'when code is invalid' do
      let(:error) { double(Sawyer::Resource, error: 'bad_verification_code') }
      before do 
        allow_any_instance_of(Octokit::Client).to receive(
          :exchange_code_for_token).and_return(error)
      end

      it 'raises authentication error' do
        expect { subject }.to raise_error(
          UserAuthenticator::AuthenticationError
        )
        expect(authenticator.user).to be_nil
      end
    end

    context 'when code is valid' do
      let(:user_data) do
        {
          login: 'jsmith1',
          url: 'http://example.com',
          avatar_url: 'http://example.com/avatar',
          name: 'John Smith'
        }
      end

      before do
        allow_any_instance_of(Octokit::Client).to receive(
          :exchange_code_for_token).and_return('validAccessToken')

        allow_any_instance_of(Octokit::Client).to receive(
          :user).and_return(user_data)
      end

      it 'should save the user when does not exist' do
        expect{ subject }.to change(User, :count).by(1)
        expect(User.last.name).to eq('John Smith')
      end

      it 'should find the user when exists' do
        user = create :user, user_data
        expect{ subject }.not_to change(User, :count)
        expect(authenticator.user).to eq(user)
      end

      it 'should create and set user access token' do
        expect{ subject }.to change(AccessToken, :count).by(1)
        expect(authenticator.access_token).to be_present
      end
    end
  end
end
