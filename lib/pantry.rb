require 'pry'

class Pantry
  attr_reader :stock, :shopping_list, :cookbook

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook = []
    @potential_recipes = potential_recipes
  end

  def stock_check(item)
    @stock[item]
  end

  def restock(item, quantity)
    @stock[item] += quantity
  end

  def add_to_shopping_list(recipe)
    items = recipe.ingredients
    @shopping_list = @shopping_list.merge(items) do |item, list_qty, recipe_qty|
      list_qty + recipe_qty
    end
  end

  def print_shopping_list
    @shopping_list.each do |item, qty|
      puts "#{item}: #{qty}"
    end
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def potential_recipes
    all_potential_recipes = Hash.new(0)
    @cookbook.map do |recipe|
      remaining_items = Hash.new

      recipe.ingredients.map do |item, qty|
        remaining_items[item] = @stock[item]
      end

      remaining_items.map do |item, qty|
        while remaining_items.values.all? { |qty| qty > 0 }
          remaining_items[item] =
            remaining_items[item] - recipe.ingredients[item]
          if remaining_items.values.all? { |qty| qty >= 0 }
            all_potential_recipes[recipe.name] += 1
          end
        end
      end
    end
    return all_potential_recipes
  end


  def what_can_i_make
    potential_recipes.keys
  end

  def how_many_can_i_make
    potential_recipes
  end















end
