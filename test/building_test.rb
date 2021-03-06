require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/apartment'
require './lib/building'

class BuildingTest < Minitest::Test

  def setup
    @building = Building.new
    @a1 = Apartment.new({ number: "A1",
                          monthly_rent: 1200,
                          bathrooms: 1,
                          bedrooms: 1
                          })

    @b2 = Apartment.new({ number: "B2",
                          monthly_rent: 999,
                          bathrooms: 2,
                          bedrooms: 2
                          })
    @spencer = Renter.new("Spencer")
    @jessie = Renter.new("Jessie")
  end

  def test_building_exists
    assert_instance_of Building, @building
  end

  def test_building_units_starts_as_empty_array
    assert_equal [], @building.units
  end

  def test_add_units_to_building
    @building.add_unit(@a1)
    @building.add_unit(@b2)

    assert_equal [@a1, @b2], @building.units
  end

  def test_average_rent
    @building.add_unit(@a1)
    @building.add_unit(@b2)

    assert_equal 1099.5, @building.average_rent
  end

  def test_renter_with_highest_rent_with_only_one_renter
    @b2.add_renter(@spencer)
    @building.add_unit(@a1)
    @building.add_unit(@b2)

    assert_equal @spencer, @building.renter_with_highest_rent
  end

  def test_highest_rent_with_multiple_renters
    @b2.add_renter(@spencer)
    @building.add_unit(@a1)
    @building.add_unit(@b2)
    @a1.add_renter(@jessie)

    assert_equal @jessie, @building.renter_with_highest_rent
  end

  def test_annual_breakdown_with_one_renter
    @b2.add_renter(@spencer)
    @building.add_unit(@a1)
    @building.add_unit(@b2)
    expected = {"Spencer" => 11988}

    assert_equal expected, @building.annual_breakdown
  end

  def test_annual_breakdown_with_two_renters
    @b2.add_renter(@spencer)
    @building.add_unit(@a1)
    @building.add_unit(@b2)
    @a1.add_renter(@jessie)
    expected = { "Jessie" => 14400,
                 "Spencer" => 11988
                }

    assert_equal expected, @building.annual_breakdown
  end

end
