defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  @aged_brie "Aged Brie"
  @backstage_pass "Backstage passes to a TAFKAL80ETC concert"
  @sulfura "Sulfuras, Hand of Ragnaros"
  @conjured "Conjured"

  @max_quality 50
  @min_quality 0

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(item) do
    item
    |> decrease_sell_in
    |> update_item_quality
  end

  defp decrease_sell_in(item = %{name: @sulfura}), do: item

  defp decrease_sell_in(item) do
    %{item | sell_in: item.sell_in - 1}
  end

  defp update_item_quality(item = %{name: name}) when name == @aged_brie do
    item
    |> increase_quality
  end

  defp update_item_quality(item = %{name: name, sell_in: sell_in}) when name == @backstage_pass and sell_in < 0 do
    %{item | quality: 0}
  end

  defp update_item_quality(item = %{name: name, sell_in: sell_in}) when name == @backstage_pass and sell_in < 6 do
    item
    |> increase_quality
    |> increase_quality
    |> increase_quality
  end

  defp update_item_quality(item = %{name: name, sell_in: sell_in}) when name == @backstage_pass and sell_in < 11 do
    item
    |> increase_quality
    |> increase_quality
  end

  defp update_item_quality(item = %{name: name, sell_in: sell_in}) when name == @backstage_pass do
    item
    |> increase_quality
  end

  defp update_item_quality(item = %{name: name}) when name == @sulfura, do: item

  defp update_item_quality(item = %{name: name}) when name == @conjured do
    item
    |> decrease_quality
    |> decrease_quality
  end

  defp update_item_quality(item = %{sell_in: sell_in}) when sell_in < 0 do
    item
    |> decrease_quality
    |> decrease_quality
  end

  defp update_item_quality(item) do
    item
    |> decrease_quality
  end

  defp increase_quality(item = %{quality: quality}) when quality < @max_quality do
    %{item | quality: quality + 1}
  end

  defp increase_quality(item), do: item

  defp decrease_quality(item = %{quality: quality}) when quality > @min_quality do
    %{item | quality: quality - 1}
  end

  defp decrease_quality(item), do: item
end
