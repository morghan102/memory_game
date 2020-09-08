require "byebug"
require_relative "./board.rb"


class ComputerPlayer

    attr_accessor :name, :match_guessing_now
    # matches? knowncards?

  def initialize(name)
    @name = name
    @known_cards = {}
    @matches = []
    @last_guess = []
    @match_guessing_now = match_guessing_now #does this need to be an instance var?
    @sec_guess_complete = false
  end



  def receive_revealed_card(pos, val)
    if @known_cards[val] && !@known_cards.has_value?([pos])
    #so this didnt work.... is bc they are double arrs. so i added another
    # arr arnd it 
      @known_cards[val] << pos

    elsif @sec_guess_complete == false
      @last_guess = [pos, val]
    else
      @known_cards[val] = [pos]
    end
# meeeybe i fixed that
    @known_cards[@last_guess[1]] = [@last_guess[0]] if @last_guess != [] && @sec_guess_complete

  end

#!!!!!!!!!!!# if it gets a match, needs to delete it from the known cards
  def receive_match(pos_one, pos_two)
    @matches.push(pos_one, pos_two)
    @known_cards.delete_if { |k,v| v.include?(pos_one) || v.include?(pos_two) } #it is deleting that k/v from known_c!!!
  end

  def prompt(num)
    # system("clear") if num != 1
  end

  def first_guess(size) # do i need to put it in matches from here?
    comp_guess = []
    @last_guess = []

    @sec_guess_complete = false
    if @known_cards.length > 2
      @known_cards.each do |k,v|
        if v.length > 1           
         
          @match_guessing_now = {k=>[v[0], v[1]]}
          return comp_guess = v[0] 

        # else
        #   comp_guess = [rand(size), rand(size)]
        end
      end
    else #if no known cards
          comp_guess = [rand(size), rand(size)]
          
      end
    # end
    comp_guess
  end
  
  def sec_guess(size)
    comp_guess = []
    # @known_cards.each do |k,v|
      if !@match_guessing_now.nil?
# debugger
        @match_guessing_now.each { |k,v| comp_guess = v[1] }
      @match_guessing_now = nil
      
      
      elsif @known_cards.has_key?(@last_guess[1])#@last_guess != [] #if i have smth in last guess i can use
#the val of the last guess matches smth in known_cards, guess the one in known cards
# OK SOOOO DONT ADD THE LAST GUESS TO KNOWN CARDS, I'LL JUST DO .INCLUDE?
        comp_guess = @known_cards[@last_guess[1]]


      else
        comp_guess = [rand(size), rand(size)]

        

      end
      # if v.length > 1 
      #   # debugger
      #   comp_guess = v[1] 
      #   @known_cards.delete(k)
      # end
    # end
    @sec_guess_complete = true
    comp_guess
  end


  #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! shdnt need this!!!!
  # def find_matches
  #   # debugger
  #   match = @known_cards.select do |pos, val|
  #     # if @known_cards.has_value?(val)
  #       # will it return true bc of the card its checking agst?
  #     @known_cards.each do |k, v|
  #       val == v
  #     end
  #   end
  #     p match
  # end

end