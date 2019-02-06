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

  def renter_with_highest_rent
    # Assumes rents > 0
    highest_rent = 0
    # Default return text if all renters are nil
    highest_renter = "No renters in building."
    @units.each { |unit|
      if !unit.renter.nil? && unit.monthly_rent > highest_rent
        highest_rent = unit.monthly_rent
        highest_renter = unit.renter
      end
     }
    highest_renter
  end

  def annual_breakdown
    result = {}
    @units.each { |unit|
      if !unit.renter.nil?
        result[unit.renter.name] = 12 * unit.monthly_rent
      end
    }
    result
  end

end
