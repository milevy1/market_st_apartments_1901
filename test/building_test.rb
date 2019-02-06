require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/apartment'
require './lib/building'

class BuildingTest < Minitest::Test

  def setup
    @building = Building.new
  end

  def test_building_exists
    assert_instance_of Building, @building
  end

  def test_building_units_starts_as_empty_array
    assert_equal [], @building.units
  end

end
