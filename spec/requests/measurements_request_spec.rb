require 'rails_helper'

RSpec.describe 'Measurements', type: :request do
  def confirm_and_login_user(user)
    post '/login', params: { username: user.username, password: 'password' }
    token = JSON.parse(response.body)['token']
  end

  let(:activity) { Activity.create!(title: 'test', total: 12) }

  let!(:measurement_params) do
    measurement_params = {
      date: 'December 17, 1995 03:24:00',
      duration: 2.0,
      activity_id: activity.id
    }
  end

  describe 'Fetching Measurements without token' do
    it 'reponds with invalid request without JWT' do
      get '/activities/1/measurements'
      expect(response).to have_http_status(401)
      expect(response.body).to match(/Please log in/)
    end

    it 'fetching measurements with some available token' do
      user = FactoryBot.create(:user)
      activity = FactoryBot.create(:activity)
      measurement = FactoryBot.create(:measurement)
      jwt = confirm_and_login_user(user)

      get "/activities/#{activity.id}/measurements", headers: {
        'Authorization' => "Bearer #{jwt}"
      }
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).size).to_not eq(0)
    end

    it 'Getting one measurement with some available token' do
      user = FactoryBot.create(:user)
      activity = FactoryBot.create(:activity)
      measurement = FactoryBot.create(:measurement)
      jwt = confirm_and_login_user(user)

      get "/activities/#{activity.id}/measurements/#{measurement.id}", headers: {
        'Authorization' => "Bearer #{jwt}"
      }
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).size).to_not eq(2)
      expect(JSON.parse(response.body).size).to_not eq(3)
    end

    it 'Posting  a measurement with some available token' do
      user = FactoryBot.create(:user)
      activity = FactoryBot.create(:activity)
      jwt = confirm_and_login_user(user)

      post "/activities/#{activity.id}/measurements", params: {
        measurement: measurement_params
      }, headers: { 'Authorization' => "Bearer #{jwt}" }
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).size).to_not eq(2)
      expect(JSON.parse(response.body).size).to_not eq(3)
      expect(JSON.parse(response.body).size).to_not eq(4)
    end

    it 'Deleting an activity with some available token' do
      user = FactoryBot.create(:user)
      activity = FactoryBot.create(:activity)
      jwt = confirm_and_login_user(user)
      measurement = FactoryBot.create(:measurement)

      delete "/activities/#{activity.id}/measurements/#{measurement.id}", params: {
        measurement: measurement_params
      }, headers: { 'Authorization' => "Bearer #{jwt}" }
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body).size).to_not eq(0)
    end
  end
end
