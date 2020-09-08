require_relative "./board.rb"
require_relative "./card.rb"
require_relative "./human_player.rb"
require_relative "./computer_player.rb"
require "byebug"

# human_player - what i need to worry about is places i put in input
# and where the console gives output/information

class Game

  attr_accessor :previous_guess, :board, :current_guess, :board_length

  def initialize(gamers={}, size=4) #names = {} is how i did it in the ttt game
    @board = Board.new(size)
    @previous_guess = []
    @current_guess = [] 
    @players = gamers.map do |name, type|
      if type
         HumanPlayer.new(name)
      else
        ComputerPlayer.new(name)
      end
    end
    @current_player = @players[0]
  end

  def play
    @board.populate
    until self.over? 
      @board.render 
      puts
      # debugger
      @current_player.prompt(1)
      guess = @current_player.first_guess(@board.grid.length) 
      if !card_available?(guess)
        puts "Guess again"
      guess = @current_player.first_guess(@board.grid.length) 
      end
      # until guess.facedown == true
      #   # @board.grid  @current_player.first_guess(@board.grid.length
      #   guess = @current_player.first_guess(@board.grid.length)
      # # if @board.grid(first_guess).facedown == true
      # #   make_guess(first_guess)
      # # else

      # end
      make_guess(guess)
      puts
      switch_turn         
    end
  end

  def switch_turn
    @current_player = @players.rotate![0]
  end

  # pretty sure i dont need this... could use a error maker tho
  # def make_pos_arr(pos) #puts pos into array
      
  #   if arr.length != 2 || @board.size <= arr[0] || @board.size <= arr[1] #doesnt exist on board
  #     raise "That is not a valid position"
  #   end
  # end



  def check_match(one, two)
      if @current_guess.value == @previous_guess.value
        @current_player.prompt(2)
        input_revealed_match(one, two)
      else
        sleep(2)
        @current_player.prompt(3)
        @current_guess.swap
        @previous_guess.swap 
      end
  end

  def prep_board(pos)
      @board.reveal(pos)
      @board.render
      input_revealed_card(pos, @board.grid[pos[0]][pos[1]].value)
      # need diff method
      
  end

  def card_available?(pos)
    return false if !@board.grid[pos[0]][pos[1]].facedown
    true
  end



  def make_guess(pos)
    
    prep_board(pos)
    

    # if (@board.cards.count { |card| !card.facedown }).odd?
      @previous_guess = @board.grid[pos[0]][pos[1]]
      @current_player.prompt(1)

      new_pos = @current_player.sec_guess(@board.grid.length)
      if !card_available?(new_pos)
        puts "Guess again"
        new_pos = @current_player.sec_guess(@board.grid.length)
      end
      prep_board(new_pos)

      @current_guess = @board.grid[new_pos[0]][new_pos[1]]
      check_match(pos, new_pos)
      #input_revealed_match(@current_guess, @previous_guess)
        # i need the pos's

    # else
        # debugger 
        # IT DOES? or does it?, WEIRLDLY AFTER THE HUMAN PLAYER'S 1ST TURN. IDK WHY
        # @previous_guess = @board.grid[pos[0]][pos[1]]
    # end
  end

  def over?
    return true if @board.cards.all? { |card| !card.facedown }
    false
  end

  # atm, nly the comp diesnt see the human players moves. i dont like that
  def input_revealed_card(pos, val) #works!!
    @current_player.receive_revealed_card(pos, val)
  end

  def input_revealed_match(one, two) 
    # error w recieving the match, the pos_one
    @current_player.receive_match(one, two)
  end
end