require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def test_it_exists_with_attributes
    item = Item.new({name: 'Tomato', price: '$0.50'})

    assert_instance_of Item, item
    assert_equal 'Tomato', item.name
    assert_equal 0.5, item.price
  end
end
