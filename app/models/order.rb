class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy

  STATUSES = %w[pending paid shipped completed cancelled].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :total_cents, numericality: { greater_than_or_equal_to: 0 }

  after_create :send_confirmation_email

  def cancellable?
    %w[pending paid].include?(status)
  end

  def total
    Money.new(total_cents)
  end

  def decorate
    OrderDecorator.new(self)
  end

  private

  def send_confirmation_email
    Rails.logger.info "[ORDER ##{id}] 確認メールを送信(dummy)"
  end
end
