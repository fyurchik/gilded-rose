class ItemType
  def update(item)
    update_quality(item)
    update_sell_in(item)
    update_quality(item) if expired?(item)
  end

  protected

  def update_quality(item)
    item.quality -= 1 if item.quality > 0
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end
  def expired?(item)
    item.sell_in < 0
  end
end

class AgedBrie < ItemType
  protected

  def update_quality(item)
    item.quality += 1 if item.quality< 50
  end
end

class BackstagePass < ItemType

  protected

  def update_quality(item)
    if item.sell_in<= 0
      item.quality = 0
    elsif item.sell_in <= 5
      item.quality += 3
    elsif item.sell_in <= 10
     item.quality += 2
    else
      item.quality +=1
    end
    item.quality =[item.quality, 50].min
  end
end

class Sulfuras < ItemType
  def update(item)
    #nohing to change
  end
end

class Conjured < ItemType
  protected

  def update_quality(item)
    2.times {super}
  end
end

class NormalItem < ItemType
end

class ItemTypeFactory
  ITEM_TYPES = {
    "Aged Brie"                                 => AgedBrie,
    "Backstage passes to a TAFKAL80ETC concert" => BackstagePass,
    "Sulfuras, Hand of Ragnaros"                => Sulfuras,
    "Conjured"                                  => Conjured
  }

  def self.create(item)
    (ITEM_TYPES[item.name] || NormalItem).new
  end
end

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
     ItemTypeFactory.create(item).update(item)
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
