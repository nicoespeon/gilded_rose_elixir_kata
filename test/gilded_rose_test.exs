defmodule GildedRoseTest do
  use ExUnit.Case

  test "item quality and sold date decrease by 1 after an update" do
    item = [%Item{name: "Carrots", sell_in: 9, quality: 4}]
    expected_result = [%Item{name: "Carrots", sell_in: 8, quality: 3}]

    result = GildedRose.update_quality(item)

    assert result == expected_result
  end

  test "item quality decrease by 2 when item is expired" do
    item = [%Item{name: "Carrots", sell_in: 0, quality: 4}]
    expected_result = [%Item{name: "Carrots", sell_in: -1, quality: 2}]

    result = GildedRose.update_quality(item)

    assert result == expected_result
  end

  test "item quality can't be negative" do
    item = [%Item{name: "Carrots", sell_in: 4, quality: 0}]
    expected_result = [%Item{name: "Carrots", sell_in: 3, quality: 0}]

    result = GildedRose.update_quality(item)

    assert result == expected_result
  end

  test "aged brie quality increase with time" do
    item = [%Item{name: "Aged Brie", sell_in: 9, quality: 1}]
    expected_result = [%Item{name: "Aged Brie", sell_in: 8, quality: 2}]

    result = GildedRose.update_quality(item)

    assert result == expected_result
  end

  test "item quality can't be greater than 50" do
    item = [%Item{name: "Aged Brie", sell_in: 9, quality: 50}]
    expected_result = [%Item{name: "Aged Brie", sell_in: 8, quality: 50}]

    result = GildedRose.update_quality(item)

    assert result == expected_result
  end

  test "sulfuras has no peremption date" do
    item = [%Item{name: "Sulfuras, Hand of Ragnaros", quality: 80}]
    expected_result = [%Item{name: "Sulfuras, Hand of Ragnaros", quality: 80}]

    result = GildedRose.update_quality(item)

    assert result == expected_result
  end

  test "backstage pass quality increase by 2 when it is sold in less than 10 days" do
    item = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}]
    expected_result = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

    result = GildedRose.update_quality(item)

    assert result == expected_result
  end

  test "backstage pass quality increase by 3 when it is sold in less than 5 days" do
    item = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 4, quality: 1}]
    expected_result = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 3, quality: 4}]

    result = GildedRose.update_quality(item)

    assert result == expected_result
  end

  test "backstage pass quality falls to 0 after the concert" do
    item = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 13}]
    expected_result = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: -1, quality: 0}]

    result = GildedRose.update_quality(item)

    assert result == expected_result
  end

  test "conjured item quality decrease by 2 after an update" do
    item = [%Item{name: "Conjured", sell_in: 4, quality: 13}]
    expected_result = [%Item{name: "Conjured", sell_in: 3, quality: 11}]

    result = GildedRose.update_quality(item)

    assert result == expected_result
  end
end
