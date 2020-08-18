require_relative "./card.rb"
require "byebug"

class Board

  attr_accessor :cards, :size, :grid

  def initialize(n=4)
    @size = (n += 1 if (n*n).odd?) || n
    @grid = grid #Array.new(n) { Array.new(n) {1} }
    @cards = []
  end


  def make_deck
    ((@size*@size)/2).times do
        @cards << Card.new
    end
    @cards << @cards.clone
    @cards = @cards.flatten.shuffle!
  end


  def populate(size=@size)
    make_deck
    @grid = @cards.each_slice(@size).to_a
  end




end
