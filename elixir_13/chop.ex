defmodule Chop do

  def guess(expected, range) do
    take_a_guess(range)
    |> ask
    |> decide(expected, range)
  end

  defp ask(guess) do
    IO.puts "Is it #{guess}"
    guess
  end

  defp take_a_guess(l..r) do
    div(l + r, 2)
  end

  defp should_go_again?(guess, result) do
    result === guess
  end

  defp decide(guess, result, range) do
    should_go_again?(guess, result)
    |> take_action(guess, result, range)
  end

  defp take_action(true, guess, _, _) do
    IO.puts guess
  end

  defp take_action(false, guess, result, l.._r) when (guess > result) do
    guess(result, l..guess)
  end

  defp take_action(false, guess, result, _l..r) do
    guess(result, guess..r)
  end
end
