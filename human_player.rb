class HumanPlayer

  attr_accessor :name

  def initialize(name)
    # debugger
    @name = name
    @num_wins = 0 #meys dont need this?
  end

  def guess
    gets.chomp.split(" ").map(&:to_i)
  end


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
  end

end