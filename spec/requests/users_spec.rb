require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'GET /users' do
    context 'ユーザーが存在する場合' do
      let!(:user) { create(:user, name: 'Alice', age: 20) }

      it '200を返してユーザー一覧が含まれる' do
        get '/users'

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body.first['name']).to eq 'Alice'
      end
    end
  end

  describe 'POST /users' do
    context '正常パラーメタの場合' do
      let(:params) { { user: { name: 'Bob', age: 25 } } }

      it '201を返してユーザーが作成される' do
        post '/users', params: params

        expect(response).to have_http_status(:created)
        expect(response.parsed_body['name']).to eq 'Bob'
      end
    end

    context 'nameが空の場合' do
      let(:params) { { user: { name: nil, age: 25 } } }

      it '422を返す' do
        post '/users', params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /users/:id' do
    context '存在するidの場合' do
      let!(:user) { create(:user) }

      it '200を返す' do
        get "/users/#{user.id}"

        expect(response).to have_http_status(:ok)
      end
    end

    context '存在しないidの場合' do
      it '404を返す' do
        get '/users/9999'

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
