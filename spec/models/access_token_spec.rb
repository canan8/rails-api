require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe '#validations' do
    let(:user) { create :user }
    it 'should have valid factory' do
      token = create :access_token, user: user
      expect(token).to be_valid
    end

    it 'validates access token' do
      token1 = build :access_token, token: nil
      token2 = build :access_token, user: nil
      token3 = build :access_token, user: user

      expect(token1).not_to be_valid
      expect(token2).not_to be_valid
      expect(token3).to be_valid
    end
  end

  describe '#new_token' do
    it 'should have a token present after initialize' do
      expect(AccessToken.new.token).to be_present
    end

    it 'should generate unique token' do
      user = create :user
      expect{ user.create_access_token }.to change(AccessToken, :count).by(1)
      expect(user.build_access_token).to be_valid
    end
  end
end
