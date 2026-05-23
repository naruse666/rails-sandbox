class SendOrderConfirmationEmailJob < ApplicationJob
  class JobError < StandardError; end
  queue_as :default

  discard_on ActiveRecord::RecordNotFound
  retry_on JobError, wait: :polynomially_longer, attempts: 3

  def perform(order_id)
    # For test
    # raise JobError, 'TEST JOB ERROR'

    order = Order.find(order_id)
    return if order.confirmation_email_sent_at.present?

    Rails.logger.info "[ORDER ##{order.id}] 確認メールを送信(Job dummy)"

    order.update!(confirmation_email_sent_at: Time.current)
  end
end
