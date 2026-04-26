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

  describe '.adults' do
    context 'DBに大人と未成年が混在する場合' do
      # let! は即時評価
      let!(:adult) { create(:user, age: 18) }
      let!(:minor) { create(:user, age: 17) }

      it '18歳以上を返す' do
        expect(User.adults).to include(adult)
        expect(User.adults).not_to include(minor)
      end
    end
  end
end
