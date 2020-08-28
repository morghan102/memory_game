class ComputerPlayer

  def initialize(name)
    @name = name
    @known_cards = Hash.new
    @matches = []
  end

  def receive_revealed_card(pos, val)
# should take in a position and the value of the card revealed 
# at that location. It should then store it in a @known_cards hash.
    @known_cards[pos] = val
  end

  def receive_match(card_one, card_two)
    @matches.push(card_one, card_two)
  end

end