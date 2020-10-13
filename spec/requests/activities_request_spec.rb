# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Activities', type: :request do

  def confirm_and_login_user(user)
    post '/login', params: {username: user.username, password: 'password'}
    token = JSON.parse(response.body)['token']
  end

  let!(:artivity_params) do
    activity_params = {
      title: "sample Title",
      total: 12
    }
  end

  describe 'GET /activities' do
    it 'reponds with invalid request without JWT' do
      get '/activities'
      expect(response).to have_http_status(401)
      expect(response.body).to match(/Please log in/)
    end

    it 'fetching activties with some available token' do

      user = FactoryBot.create(:user)
      activities = FactoryBot.create(:activity)
      jwt = confirm_and_login_user(user)

      get '/activities', headers: { "Authorization" => "Bearer #{jwt}" }
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).size).to_not eq(0)
    end

    it 'Getting one activity with some available token' do

      user = FactoryBot.create(:user)
      activity = FactoryBot.create(:activity)
      jwt = confirm_and_login_user(user)

      get "/activities/#{ activity.id}", headers: { "Authorization" => "Bearer #{jwt}" }
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).size).to_not eq(2)
      expect(JSON.parse(response.body).size).to_not eq(3)
    end

    it 'Posting  an activity with some available token' do

      user = FactoryBot.create(:user)
      activity = FactoryBot.create(:activity)
      jwt = confirm_and_login_user(user)

      post "/activities", params: { activity: artivity_params }, headers: { "Authorization" => "Bearer #{jwt}" }
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).size).to_not eq(2)
      expect(JSON.parse(response.body).size).to_not eq(3)
      expect(JSON.parse(response.body).size).to_not eq(4)
    end

    it 'Deleting an activity with some available token' do

      user = FactoryBot.create(:user)
      activity = FactoryBot.create(:activity)
      jwt = confirm_and_login_user(user)

      delete "/activities/#{ activity.id }", params: { activity: artivity_params }, headers: { "Authorization" => "Bearer #{jwt}" }
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).size).to_not eq(0)
    end
  end
end
