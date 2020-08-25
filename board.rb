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
        @cards << Card.new(@cards[-1].value)
    end
    # @cards << @cards.dup #makes duplicates of entire deck
    @cards = @cards.flatten.shuffle!
  end

  def populate(size=@size)
    make_deck
    @grid = @cards.each_slice(@size).to_a
  end

  def render 
    puts "  #{(0...size).to_a.join(' ')}"
    @grid.each_with_index do |row, i|
      puts "#{i} #{(row.map do |pos| 
        if pos.facedown
          ""
        else
          pos.value
        end
    end).join(' ')}"
    end
    true
  end

  def print_cards
    puts "  #{(0...size).to_a.join(' ')}"
    @grid.each_with_index do |row, i|
      puts "#{i} #{(row.map {|pos| pos.value}).join(' ')}"
    end
    true
  end

  def reveal(pos)
    # guessed_pos = [pos[0], pos[1]]
    # w the [] methods, theyre not working. bc of them:
    # pos = a 1d arr, but i need 2d (@grid[1,1] vs @grid[1][1])
    # pos is input as [1,1]. i need to change that!!!!

    if @grid[pos[0]][pos[1]]
      @grid[pos[0]][pos[1]].swap
      @grid[pos[0]][pos[1]].value
    end
  end
  # this should then reveal where it is ONT HE BOARD, print grid

  def won?
    return true if @cards.all? { |card| !card.facedown }

    false
  end


  def [](pos)
    @cards[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @cards[pos[0]][pos[1]] = value
  end
end
