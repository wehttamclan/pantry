require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_has_stock_of_items
    pantry = Pantry.new
    assert_instance_of Hash, pantry.stock
    assert_equal 0, pantry.stock.length
  end

  def test_patry_checks_its_stock_and_adds_to_stock
    pantry = Pantry.new
    assert_equal 0, pantry.stock_check("Cheese")
    pantry.restock("Cheese", 10)
    assert_equal 10, pantry.stock_check("Cheese")
  end

  def test_pantry_adds_to_existing_stock
    pantry.restock("Cheese", 20)
    pantry.stock_check("Cheese")
    # => 30
  end


end
