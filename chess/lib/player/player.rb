# Handles creation of player instance
class Player
  attr_accessor :name,
                :color,
                :active

  def initialize(name, color)
    @name = name
    @color = color
    @active = false
  end

  def self.active_user
    ObjectSpace.each_object(self) { |player| return player if player.active }
  end

  def self.active_user_name
    ObjectSpace.each_object(self) { |player| return player.name if player.active }
  end

  def self.inactive_user_name
    ObjectSpace.each_object(self) { |player| return player.name unless player.active }
  end
end
