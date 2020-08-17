require_relative "./card.rb"
require "byebug"

class Board

  attr_accessor :cards, :size

  def initialize(n)
    @size = (n += 1 if (n*n).odd?)

    @grid = Array.new(n) { Array.new(n) }
    @cards = []
  end

  def populate(size=@size)

    ((size*size)/2).times do
        @cards << Card.new
    end
# pos.random set to card.each
    @grid.each do |row|
        row.each do |pos|
            pos += @cards.sample
        end
    end
  end


end
