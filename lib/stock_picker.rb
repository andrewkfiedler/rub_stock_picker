# frozen_string_literal: true

# analyze a list of stock prices (in order of days) and find best days to buy / sell
# my thought is to just build a matrix of buy / sell and then find the max (parts will be nil since you can't sell in the past)
module StockPicker
  # @param [Array<Integer>]
  # @return [Array<Array<Integer>>]
  def self.analyze(prices)
    analysis = Array.new(prices.length, Array.new(prices.length, nil))
    analysis.each_with_index do |outcomes, buy_day|
      # if we don't reset the array of outcomes on the next line, that default above is actually only making one array, which means all outcomes will overwrite one another
      outcomes = Array.new(prices.length, nil)
      price = prices[buy_day]
      first_outcome_index = buy_day + 1
      nil_index = 0
      while nil_index < first_outcome_index
        outcomes[nil_index] = nil
        nil_index += 1
      end
      current_outcome_index = first_outcome_index
      while current_outcome_index < prices.length
        outcomes[current_outcome_index] = prices[current_outcome_index] - price
        current_outcome_index += 1
      end
      analysis[buy_day] = outcomes
    end
    analysis  
  end
  # @param [Array<Integer>]
  def self.pick(prices) 
    analysis = analyze(prices)
    buy = nil
    sell = nil
    best_profit = 0
    # now we have a matrix of each possibility, let's find the max and return it
    analysis.each_with_index do |outcomes, buy_day|
      outcomes.each_with_index do |profit, sell_day|
        next unless profit && profit > best_profit

        best_profit = profit
        buy = buy_day
        sell = sell_day
      end
    end
    [buy, sell]
  end
end
