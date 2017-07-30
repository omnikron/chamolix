class Line
  PROPERTIES = %i[id description name ski_difficulty geo_data]

  attr_accessor *PROPERTIES

  class << self
    delegate :count, :search, :sort, to: :collection

    def all
      collection.lines
    end

    def collection
      LineCollection.new
    end
  end

  def initialize(hash)
    hash.slice(*PROPERTIES).each do |key, value|
      send("#{key}=", value)
    end
  end

  def coordinates
    return nil if geo_data.blank?

    @coordinates = geo_data.dig("coordinates").map do |coords|
      Coordinates.new(coords)
    end
  end

  def to_hash
    {id: id, description: description, name: name, ski_difficulty: ski_difficulty }
  end

  def cache_key
    "line_#{id}"
  end
end
