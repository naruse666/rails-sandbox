require 'delegate'

class AddressDecorator < SimpleDelegator
  def full_address
    "#{postal_code} #{prefecture}#{city}#{street}"
  end
end
