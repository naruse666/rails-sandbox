require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) { build(:post) }

  it_behaves_like 'validatable'
  it_behaves_like 'required_attr', :title
  it_behaves_like 'required_attr', :body

  describe '#summary' do
    it 'タイトルと投稿者名を返す' do
      expect(post.summary).to include('テスト投稿')
    end
  end
end
