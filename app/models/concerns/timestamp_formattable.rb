module TimestampFormattable
  extend ActiveSupport::Concern

  def created_at_formatted
    created_at&.strftime('%Y/%m/%d %H:%M')
  end

  def updated_at_formatted
    updated_at&.strftime('%Y/%m/%d %H:%M')
  end
end
