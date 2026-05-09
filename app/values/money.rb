class Money
  include Comparable

  attr_reader :cents

  def initialize(cents)
    raise ArgumentError, 'cents must be an integer' unless cents.is_a?(Integer)

    @cents = cents
    freeze
  end

  class << self
    def from_yen(yen)
      new(yen * 100)
    end

    def zero
      new(0)
    end
  end

  def yen
    @cents / 100
  end

  def formatted
    "¥#{ActiveSupport::NumberHelper.number_to_delimited(yen)}"
  end

  def add(other)
    raise ArgumentError, 'Money 同士でないと加算できません' unless other.is_a?(Money)

    Money.new(@cents + other.cents)
  end

  def +(other)
    add(other)
  end

  def *(other)
    raise ArgumentError, 'Integerをかけてください' unless other.is_a?(Integer)

    Money.new(@cents * other)
  end

  def zero?
    @cents.zero?
  end

  def <=>(other)
    return nil unless other.is_a?(Money)

    @cents <=> other.cents
  end

  def ==(other)
    other.is_a?(Money) && @cents == other.cents
  end

  alias eql? ==

  def hash
    @cents.hash
  end
end
