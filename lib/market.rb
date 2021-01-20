class Market
  attr_reader :name,
              :vendors,
              :date

  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today
  end

  def add_vendor(vendor)
    @vendors.push(vendor)
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item_name)
    @vendors.find_all do |vendor|
      vendor.sell?(item_name)
    end
  end

  def sorted_item_list
    item_list = @vendors.map do |vendor|
      vendor.inventory.keys
    end.flatten.uniq

    item_list.map do |item|
      item.name
    end.sort
  end

  def total_inventory
    total_inventory = {}

    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        total_inventory[item] ||= {quantity: 0, vendors: []}

        total_inventory[item][:quantity] += quantity
        total_inventory[item][:vendors].push(vendor)
      end
    end
    total_inventory
  end

  def overstocked_items
    overstocked = []
    total_inventory.each do |item, info|
      overstocked.push(item) if info[:quantity] > 50 && info[:vendors].length > 1
    end
    overstocked
  end

  def sell(item, quantity)
    if total_inventory[item].nil? || total_inventory[item][:quantity] < quantity
      return false
    end

    vendors_that_sell(item).each do |vendor|
      if vendor.check_stock(item) >= quantity
        vendor.sell(item, quantity)
        quantity = 0
      else
        quantity -= vendor.check_stock(item)
        vendor.sell(item, vendor.check_stock(item))
      end
    end
  end
end
