require 'pry'

class Pantry
  attr_reader :stock, :shopping_list, :cookbook

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook = []
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
end
