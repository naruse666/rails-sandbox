# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:name) { 'Alice' }
  let(:age) { 20 }
  let(:user) { User.new(name: name, age: age) }

  describe '#greet' do
    it 'Hello + 名前の文字列を返す' do
      expect(user.greet).to eq 'Hello, Alice!'
    end
  end

  describe '#adult?' do
    context '18歳以上の場合' do
      let(:age) { 18 }

      it 'trueを返す' do
        expect(user.adult?).to be true
      end
    end
    context '17歳以下の場合' do
      let(:age) { 17 }

      it 'falseを返す' do
        expect(user.adult?).to be false
      end
    end
  end
end
