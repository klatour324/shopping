class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
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
end
