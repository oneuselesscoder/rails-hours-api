require 'rails_helper'
require 'date'

RSpec.describe 'Hours API' do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:hours) { create_list(:hour, 20, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { hours.first.id }

  # Test suite for GET /users/:user_id/hours
  describe 'GET /users/:user_id/hours' do
    before { get "/users/#{user_id}/hours" }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user hours' do
        expect(json.size).to eq(20)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for GET /users/:user_id/hours/:id
  describe 'GET /users/:user_id/hours/:id' do
    before { get "/users/#{user_id}/hours/#{id}" }

    context 'when user hour exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the hour' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user hour does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Hour/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/hours
  describe 'POST /users/:user_id/hours' do
    timer = (Date.current+2).to_datetime
    let(:valid_attributes) { { starts: timer, ends: timer } }
    let(:mixed_attributes) { { starts: "2018-10-07 10:31 am", ends: "2018-10-07 02:00 pm" } }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/hours", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request has 12h time valid attributes' do
      before { post "/users/#{user_id}/hours", params: mixed_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns stores correct time' do
        res = JSON.parse(response.body)
        expect(res["starts"]).to match("2018-10-07T10:31:00.000Z")
        expect(res["ends"]).to match("2018-10-07T14:00:00.000Z")
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/hours", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Starts can't be blank, Ends can't be blank/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/hours/:id
  describe 'PUT /users/:user_id/hours/:id' do
    timer = (Date.current+2).to_datetime
    let(:valid_attributes) { { starts: timer, ends: timer } }

    before { put "/users/#{user_id}/hours/#{id}", params: valid_attributes }

    context 'when hour exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the hour' do
        updated_hour = Hour.find(id)
        expect(updated_hour.starts).to match(timer)
      end
    end

    context 'when the hour does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Hour/)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}/hours/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end