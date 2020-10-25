require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  describe 'Login User' do
    it 'responds a valid request with JWT' do
      post '/login'
      token = JSON.parse(response.body)['token']

      expect(JSON.parse(response.body).size).to eq(1)
      expect { JWT.decode(token, key) }.to_not raise_error(JWT::DecodeError)
    end
  end
end
