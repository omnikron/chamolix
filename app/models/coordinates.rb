class Coordinates
  attr_reader :geo_points, :points

  def initialize(coordinates = [])
    @geo_points = coordinates.map do |coords|
      Point.new(*coords[0..1])
    end

    @points ||= coordinates.map do |coords|
      Point.new(*convert_to_canvas_coords(coords))
    end
  end

  def convert_to_canvas_coords(coords)
    geo_x = coords[0]
    geo_y = coords[1]

    width_ratio = (geo_x - min_x) / geo_width * 20
    height_ratio = (geo_y - min_y) / geo_height * 10
    [geo_x * width_ratio, geo_y * height_ratio]
  end

  private

  def min_x
    geo_points.map(&:x).min
  end

  def max_x
    geo_points.map(&:x).max
  end

  def min_y
    geo_points.map(&:y).min
  end

  def max_y
    geo_points.map(&:y).max
  end

  def geo_width
    max_x - min_x
  end

  def geo_height
    max_y - min_y
  end
end
