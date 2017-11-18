defmodule Cards do
  def draw do
    create
    |> deal 5
  end

  def create do
    Enum.reduce( numbers, [], &(combine(&1) ++ &2))
  end

  def suits do
    [ :spade, :heart, :club, :diamond ]
  end

  def numbers do
    1..13
  end

  def combine number do
    Enum.map suits, &({ &1, number })
  end

  def deal cards, 0 do
    { [], cards }
  end

  def deal cards, total do
    with card = Enum.random( cards ),
      remaining_deck = Enum.filter( cards, &(&1 != card) ),
      { hand, _ } = deal( remaining_deck, total - 1 )
    do
      { [ card | hand ], remaining_deck }
    end
  end

end
