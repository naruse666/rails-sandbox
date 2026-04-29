require 'rails_helper'

RSpec.describe GithubService do
  describe '#fetch_user' do
    subject(:service) { GithubService.new }

    context 'APIが成功を返す場合' do
      before do
        stub_request(:get, 'https://api.github.com/users/alice')
          .to_return(
            status: 200,
            body: { login: 'alice', name: 'Alice' }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it 'ユーザー情報を返す' do
        result = service.fetch_user('alice')
        expect(result['login']).to eq 'alice'
        expect(result['name']).to eq 'Alice'
      end
    end

    context 'APIが404を返す場合' do
      before do
        stub_request(:get, 'https://api.github.com/users/nobody')
          .to_return(status: 404, body: '')
      end

      it 'nilを返す' do
        result = service.fetch_user('nobody')
        expect(result).to be_nil
      end
    end
  end
end
