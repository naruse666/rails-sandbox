require 'delegate'

class OrderDecorator < SimpleDelegator
  STATUS_LABELS = {
    'pending' => '注文受付',
    'paid' => '支払い済み',
    'shipped' => '発送済み',
    'completed' => '完了',
    'cancelled' => 'キャンセル'
  }.freeze

  def status_label
    STATUS_LABELS[status]
  end

  def created_at_formatted
    created_at.strftime('%Y/%m/%d %H:%M')
  end
end
