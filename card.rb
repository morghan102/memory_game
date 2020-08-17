require "byebug"

class Card

  def initialize
    alpha = ("a".."z").to_a
    # @faceup = false
    @facedown = true
    @value = alpha.sample.upcase
  end

  def display_value
    # debugger
    if @facedown == false
        @value 
    else
        false
    end
  end

  def swap
    if @facedown
        @facedown= false
    else
        @facedown = true
    end
  end

  def hide_or_reveal
    swap
  end

end

#hide, #reveal, #to_s, and #==