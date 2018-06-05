require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PantryTest < Minitest::Test
  def setup
    @pantry = Pantry.new
    @recipe_1 = Recipe.new("Cheese Pizza")
    @recipe_2 = Recipe.new("Spaghetti")
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
    @recipe_1.add_ingredient("Flour", 20)
    @recipe_1.add_ingredient("Cheese", 20)
    @pantry.add_to_shopping_list(@recipe_1)
    expected = {"Cheese" => 20, "Flour" => 20}
    assert_equal expected, @pantry.shopping_list
  end

  def test_pantry_adds_to_existing_shopping_list_like_a_boss
    @recipe_1.add_ingredient("Flour", 20)
    @recipe_1.add_ingredient("Cheese", 20)
    @pantry.add_to_shopping_list(@recipe_1)
    @recipe_2.add_ingredient("Spaghetti Noodles", 10)
    @recipe_2.add_ingredient("Marinara Sauce", 10)
    @recipe_2.add_ingredient("Cheese", 5)
    @pantry.add_to_shopping_list(@recipe_2)
    expected = {"Cheese" => 25,
                "Flour" => 20,
                "Spaghetti Noodles" => 10,
                "Marinara Sauce" => 10}
    assert_equal expected, @pantry.shopping_list
  end

  # def test_pantry_prints_its_shopping_list
  #   @recipe_1.add_ingredient("Cheese", 20)
  #   @recipe_1.add_ingredient("Flour", 20)
  #   @pantry.add_to_shopping_list(@recipe_1)
  #   @recipe_2.add_ingredient("Spaghetti Noodles", 10)
  #   @recipe_2.add_ingredient("Marinara Sauce", 10)
  #   @recipe_2.add_ingredient("Cheese", 5)
  #   @pantry.add_to_shopping_list(@recipe_2)
  #   @pantry.print_shopping_list
  #   # * Cheese: 25
  #   # * Flour: 20
  #   # * Spaghetti Noodles: 10
  #   # * Marinara Sauce: 10
  #   # => "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
  # end

  def test_
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    @pantry.add_to_cookbook(r1)
    @pantry.add_to_cookbook(r2)
    @pantry.add_to_cookbook(r3)
    assert_equal [r1, r2, r3], @pantry.cookbook
  end
end
