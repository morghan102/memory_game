require_relative "./board.rb"
require_relative "./card.rb"
require "byebug"

class Game

  attr_accessor :previous_guess, :board

  def initialize(*size)
    @board = Board.new(*size)
    @previous_guess = []
    @current_guess = [] #do i need ths?
  end

  def play
    @board.populate
    until self.over?
        @board.render #will have flipped cards as flipped, don worry
        puts
        prompt(1)
        pos = gets.chomp.split(" ").map(&:to_i)
        make_guess(pos) #this can handle the inner loop
        # where we check the current guess agst the prev one
        
    end
  end

  # pretty sure i dont need this... could use a error maker tho
  # def make_pos_arr(pos) #puts pos into array
  #   # debugger
  #   arr = []
  #   pos.each_char { |char| arr << char.to_i if char != " " }
      
  #   if arr.length != 2 || @board.size <= arr[0] || @board.size <= arr[1] #doesnt exist on board
  #     raise "That is not a valid position"
  #   end
  #   arr
  # end

  def prompt(code)
    if code == 1
      puts "Which card would you like to flip?"
    elsif code == 2
      system("clear")
      puts "You got a match!"
    elsif code == 3
      system("clear")
      puts "Sorry, not a match."
    end
    # anything else here?? idk
  end

#   where you will handle the actual memory/matching logic. 

# If we're not already checking another Card, leave the card at 
# guessed_pos face-up and update the previous_guess variable.
# If we are checking another card, we should compare the Card at 
# guessed_pos with the one at previous_guess.
# If the cards match, we should leave them both face-up.
# Else, flip both cards face-down.
# In either case, reset previous_guess.
  def check_match
      # @board.render I put this after they make the guess
      if @current_guess.value == @previous_guess.value
        prompt(2)
      else
        sleep(2)
        prompt(3)
        @current_guess.swap #flip em back over
        @previous_guess.swap 
      end
  end


  def make_guess(pos)
    # debugger
    
    @board.reveal(pos) #guessed card is faceup now,returns value
    # system("clear")
    @board.render
    if (@board.cards.count { |card| !card.facedown }).odd?
      @previous_guess = @board.grid[pos[0]][pos[1]]
      prompt(1)
      new_pos = gets.chomp.split(" ").map(&:to_i)
      @board.reveal(new_pos)
      @board.render
      @current_guess = @board.grid[new_pos[0]][new_pos[1]]
      check_match

        # if @cards[pos] != @previous_guess
        #   @board.cards[pos].swap
        #   @previous_guess.swap #flip both facedown
        # # working on flipping them back over!!


        else
          @previous_guess = @board.grid[pos[0]][pos[1]]
    end
  end

  def over?
    return true if @board.cards.all? { |card| !card.facedown }
    false
  end

end