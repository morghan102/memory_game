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

  def render 
    puts "  #{(0...size).to_a.join(' ')}"
    @grid.each_with_index do |row, i|
      puts "#{i} #{(row.map {|pos| pos.value}).join(' ')}"
    end
    true
  end

  def reveal
    if @cards[guessed_pos] #that is the user input BUT i  need smth to tack it into the game
      @cards[guessed_pos].swap
      @cards[guessed_pos].value
    end
  end

  def won?
    return true if @cards.all? { |card| !card.facedown }

    false
  end


  def [](pos)
    @cards[pos]
  end

  def []=(pos, value)
    @cards[pos] = value
  end
end
