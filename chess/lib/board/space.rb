# Stores data for each individual space.

class Space
  attr_reader :location
  attr_accessor :piece

  def initialize(location)
    @location = location
    @piece = nil
  end
end