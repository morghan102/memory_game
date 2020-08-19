require "byebug"

class Card

  attr_accessor :value, :facedown #do i need both these?
  
  def initialize
    alpha = ("A".."Z").to_a
    # @faceup = false
    @facedown = true
    @value = alpha.sample
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