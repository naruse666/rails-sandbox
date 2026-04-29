require 'rails_helper'

RSpec.describe User, type: :model do
  # build -> DB保存しない
  # create -> DB保存
  subject(:user) { build(:user) }

  it_behaves_like 'validatable'
  it_behaves_like 'required_attr', :name
  it_behaves_like 'required_attr', :age

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

  describe '.adults', :slow do
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

  describe '#greet' do
    it 'Hello + nameを返す' do
      expect(user.greet).to eq 'Hello, Alice!'
    end
  end

  describe '#greeting_message' do
    let(:user) { build(:user, name: 'Alice') }

    context '午前中' do
      before { Timecop.freeze(Time.zone.local(2025, 1, 1, 9, 0, 0)) }
      after { Timecop.return }

      it 'おはよう' do
        expect(user.greeting_message).to eq 'Alice, おはよう'
      end
    end

    context '昼' do
      before { Timecop.freeze(Time.zone.local(2025, 1, 1, 14, 0, 0)) }
      after { Timecop.return }

      it 'こんにちは' do
        expect(user.greeting_message).to eq 'Alice, こんにちは'
      end
    end

    context '夜' do
      before { Timecop.freeze(Time.zone.local(2025, 1, 1, 20, 0, 0)) }
      after { Timecop.return }

      it 'こんばんは' do
        expect(user.greeting_message).to eq 'Alice, こんばんは'
      end
    end
  end
end
