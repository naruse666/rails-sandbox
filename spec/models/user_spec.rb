# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe '#greet' do
    it 'Hello + 名前の文字列を返す' do
      user = User.new(name: 'Alice', age: 20)
      expect(user.greet).to eq 'Hello, Alice!'
    end
  end

  describe '#adult?' do
    context '18歳以上の場合' do
      it 'trueを返す' do
        user = User.new(name: 'Alice', age: 18)
        expect(user.adult?).to be true
      end
    end
    context '17歳以下の場合' do
      it 'falseを返す' do
        user = User.new(name: 'Alice', age: 17)
        expect(user.adult?).to be false
      end
    end
  end
end
