require "byebug"

class Card

  attr_accessor :value, :facedown 
  
  def initialize(*val)
    alpha = ("A".."Z").to_a
    @facedown = true
    @value = if val.empty? #nothing passed in
      alpha.sample
    else
      val[0]
    end
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

  def hide_or_reveal #dont need this, not sure what the pt was int he 
    # 1st place
    swap
  end

end