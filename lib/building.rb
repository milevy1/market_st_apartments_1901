class Building
  attr_reader :units

  def initialize
    @units = []
  end

  def add_unit(apartment)
    @units << apartment
  end

  def average_rent
    total = @units.length
    sum = @units.sum(0.0) { |unit| unit.monthly_rent }

    return (sum / total)
  end

end
