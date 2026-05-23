class SendOrderConfirmationEmailJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    return if order.confirmation_email_sent_at.present?

    Rails.logger.info "[ORDER ##{order.id}] 確認メールを送信(Job dummy)"

    order.update!(confirmation_email_sent_at: Time.current)
  end
end
