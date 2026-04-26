require 'rails_helper'

RSpec.describe User, type: :model do
  # build -> DB保存しない
  # create -> DB保存
  subject(:user) { build(:user) }

  describe 'validation' do
    context '正常' do
      it 'valid' do
        expect(user).to be_valid
      end
    end

    context 'nameが空' do
      let(:user) { build(:user, name: nil) }

      it 'invalid' do
        expect(user).not_to be_valid
      end
    end

    context 'ageが負数' do
      let(:user) { build(:user, age: -1) }

      it 'invalid' do
        expect(user).not_to be_valid
      end
    end
  end

  describe '#adult?' do
    context '18歳以上の場合' do
      let(:user) { build(:user, age: 18) }

      it 'trueを返す' do
        expect(user.adult?).to be true
      end
    end

    context '17歳以下の場合' do
      let(:user) { build(:user, age: 17) }

      it 'falseを返す' do
        expect(user.adult?).to be false
      end
    end
  end
end
