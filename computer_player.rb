class ComputerPlayer

  def initialize(name)
    @name = name
    @known_cards = Hash.new
    @matches = []
  end

  def receive_revealed_card(pos, val)
    @known_cards[pos] = val
  end

  def receive_match(card_one, card_two)
    @matches.push(card_one, card_two)
  end

end