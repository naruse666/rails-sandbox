class Order < ApplicationRecord
  include TimestampFormattable

  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy

  STATUSES = %w[pending paid shipped completed cancelled].freeze

  TRANSITIONS = {
    'pending' => %w[paid cancelled],
    'paid' => %w[shipped cancelled],
    'shipped' => %w[completed],
    'completed' => [],
    'cancelled' => []
  }.freeze

  validates :status, inclusion: { in: STATUSES }
  validates :total_cents, numericality: { greater_than_or_equal_to: 0 }

  def cancellable?
    can_transition_to?('cancelled')
  end

  def can_transition_to?(new_status)
    TRANSITIONS[status].include?(new_status)
  end

  def transition_to!(new_status)
    raise InvalidTransition, "#{status} から #{new_status} へは遷移できません" unless can_transition_to?(new_status)

    update!(status: new_status)
  end

  class InvalidTransition < StandardError; end

  def total
    Money.new(total_cents)
  end

  def decorate
    OrderDecorator.new(self)
  end
end
