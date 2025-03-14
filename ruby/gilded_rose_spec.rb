require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe "#update_quality" do
    let(:items)       { [Item.new("Aged Brie", 5, 10), Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20), Item.new("Conjured", 3, 6)] }
    let(:gilded_rose) { GildedRose.new(items) }

    
    it "updates for Aged Brie" do
      gilded_rose.update_quality 
      expect(items[0].quality).to eq(11)
    end

    it "updates for Backstage " do
      gilded_rose.update_quality
      expect(items[1].quality).to eq(22)
    end

    it "updatefor Conjured" do
      gilded_rose.update_quality
      expect(items[2].quality).to eq(4)
    end
  end
end
