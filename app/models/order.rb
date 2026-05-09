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

  def status_label
    case status
    when 'pending' then '注文受付'
    when 'paid' then '支払い済み'
    when 'shipped' then '発送済み'
    when 'completed' then '完了'
    when 'cancelled' then 'キャンセル'
    end
  end

  def total
    Money.new(total_cents)
  end

  private

  def send_confirmation_email
    Rails.logger.info "[ORDER ##{id}] 確認メールを送信(dummy)"
  end
end
