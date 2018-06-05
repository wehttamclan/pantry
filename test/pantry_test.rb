require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PantryTest < Minitest::Test
  def setup
    @pantry = Pantry.new
    @r = Recipe.new("Cheese Pizza")
  end

  def test_has_stock_of_items
    assert_instance_of Hash, @pantry.stock
    assert_equal 0, @pantry.stock.length
  end

  def test_patry_checks_its_stock_and_adds_to_existing_stock
    assert_equal 0, @pantry.stock_check("Cheese")
    @pantry.restock("Cheese", 10)
    assert_equal 10, @pantry.stock_check("Cheese")
    @pantry.restock("Cheese", 20)
    assert_equal 30, @pantry.stock_check("Cheese")
  end

  def test_pantry_has_shopping_list_and_can_add_ingredients
    @r.add_ingredient("Flour", 20)
    @r.add_ingredient("Cheese", 20)
    @pantry.add_to_shopping_list(@r)
    expected = {"Cheese" => 20, "Flour" => 20}
    assert_equal expected, @pantry.shopping_list
  end
end
