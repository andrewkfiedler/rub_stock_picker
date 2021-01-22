# frozen_string_literal: true

require_relative './stock_picker'

RSpec.describe 'stock picker tests' do
  it 'handles anything' do
    expect(StockPicker.pick([17, 3, 6, 9, 15, 8, 6, 1, 10])).to eql([1, 4])
  end
end
