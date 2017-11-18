defmodule Poker do
  use Application

  def start(_, _) do
    dial
  end

  def dial do
    Cards.draw
    |> show
    |> score
  end

  def show { hand, deck } do
    Enum.each hand , &(IO.puts format(&1))
    { hand, deck }
  end

  def format { suit, number } do
    "#{number} of #{suit}"
  end

  def score { hand, _ } do
    decompose( hand )
    |> prepare
    |> match
  end

  def decompose hand do
    Enum.reduce( hand, { [], [] }, &combine/2 )
  end

  def combine { suit, number }, { suits, numbers } do
    { [suit | suits], [number | numbers] }
  end

  def prepare { suits, numbers } do
    { suits, order( numbers ) }
  end

  def order numbers do
    Enum.sort numbers
  end

  def match { suits, numbers } do
    result
    |> flush( suits )
    #|> straight numbers
    #|> straight_flush
    #|> royal_straight_flush
    #|> group numbers
  end

  def result do
    %{
      royal_straight_flush: 0,
      straight_flush: 0,
      four_of_a_kind: 0,
      full_house: 0,
      flush: 0,
      straight: 0,
      three_of_a_kind: 0,
      two_pairs: 0,
      one_pair: 0
    }
  end

  def flush result, suits do
    IO.inspect suits
    with distinct_suits = Enum.group_by(suits, &(&1), &length/1),
      max_suits = length(suits),
      put_result = fn 
        ^max_suits -> Map.put( result, :flush, 1 )
        _ -> result
      end
    do
      put_result.(length(distinct_suits))
    end
  end
end
