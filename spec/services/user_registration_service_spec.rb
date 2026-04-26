# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRegistrationService do
  describe '#call' do
    let(:mailer_double) { double('mailer') }
    let(:message_double) { double('message') }

    before do
      allow(mailer_double).to receive(:welcome_email).and_return(message_double)
      allow(message_double).to receive(:deliver_now)
    end

    subject(:service) { UserRegistrationService.new(mailer: mailer_double) }

    it 'ユーザーを作成' do
      user = service.call(name: 'Alice', age: 20)

      expect(user.name).to eq 'Alice'
    end

    it 'welcome_emailを送信' do
      service.call(name: 'Alice', age: 20)
      expect(message_double).to have_received(:deliver_now)
    end
  end
end
