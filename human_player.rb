class HumanPlayer

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def first_guess(size)
#ERROR HERE IN NUMBER OF ARGS!!!!


    gets.chomp.split(" ").map(&:to_i)
  end
  def sec_guess(size)
    gets.chomp.split(" ").map(&:to_i)
  end


  def prompt(code)
    if code == 1
      puts "#{@name}, which card would you like to flip?"
    elsif code == 2
      # system("clear")
      puts "#{@name}, you got a match!"
    elsif code == 3
      # system("clear")
      puts "Sorry #{@name}, not a match."
    end
  end


  def receive_revealed_card(pos, val)
  end

  def receive_match(card_one, card_two)
  end


end
