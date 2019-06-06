class Money
  include ActionView::Helpers::NumberHelper
  include Comparable

  attr_accessor :amount

  def initialize(amount)
    @amount = parse(amount)
  end

  def to_s
    "$#{number_with_delimiter(amount)}"
  end

  def to_i
    @amount || 0
  end

  def <=>(other)
    amount <=> other.amount
  end

  def -@
    Money.new(-self.amount)
  end

  private

  def parse(amount)
    amount.to_s.gsub(/[^0-9\.\-]/,'').to_i
  end

end
