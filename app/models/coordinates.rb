class Coordinates
  attr_reader :points

  def initialize(coordinates = [])
    @points = coordinates.map do |coords|
      Point.new(*coords[0..1])
    end
  end
end
