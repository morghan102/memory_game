require_relative "./board.rb"
require_relative "./card.rb"
require_relative "./human_player.rb"
require_relative "./computer_player.rb"
require "byebug"

# human_player - what i need to worry about is places i put in input
# and where the console gives output/information

class Game

  attr_accessor :previous_guess, :board, :current_guess

  def initialize(size=4, human_names)
    @board = Board.new(size)
    @previous_guess = []
    @current_guess = [] 
    @players = []

    human_names.each { |name| @players << HumanPlayer.new(name) }
        @current_player = @players[0]

  end

  def play
    @board.populate
    until self.over? 
      # if whose_turn == HumanPlayer
        @board.render 
        puts
        @current_player.prompt(1)
        make_guess(@current_player.guess)
      # else #computer
        puts
      # end
      switch_turn         
    end
  end

  # def whose_turn
  #   # debugger
  #   @players[0].class
  # end

  def switch_turn
    @players.rotate
  end

  # pretty sure i dont need this... could use a error maker tho
  # def make_pos_arr(pos) #puts pos into array
      
  #   if arr.length != 2 || @board.size <= arr[0] || @board.size <= arr[1] #doesnt exist on board
  #     raise "That is not a valid position"
  #   end
  # end



  def check_match
      if @current_guess.value == @previous_guess.value
        @current_player.prompt(2)
      else
        sleep(2)
        @current_player.prompt(3)
        @current_guess.swap #flip em back over
        @previous_guess.swap 
      end
  end

#id like an error handler for if the pos is off the board at some pt
# i need to shortne this
  def make_guess(pos)
    
    @board.reveal(pos) #guessed card is faceup now,returns value
    @board.render

    if (@board.cards.count { |card| !card.facedown }).odd?
      @previous_guess = @board.grid[pos[0]][pos[1]]
      @current_player.prompt(1)
      new_pos = gets.chomp.split(" ").map(&:to_i)
      @board.reveal(new_pos)
      @board.render
      @current_guess = @board.grid[new_pos[0]][new_pos[1]]
      # computer_get_cards- this dissapears
      check_match
        else
          @previous_guess = @board.grid[pos[0]][pos[1]]
    end
  end

  def over?
    return true if @board.cards.all? { |card| !card.facedown }
    false
  end

  def computer_get_cards
    # that format of pos might be off
    @computer_player.receive_revealed_card([pos], @previous_guess.value)
    @computer_player.receive_revealed_card([new_pos], @current_guess.value)
  end
  # ok NO i dont want specific to the comp stuff. I should make dummy methods 
  # for the humanplayer and run those methods the comp needs on
  # @currentplayer

end