class Line
  PROPERTIES = %i[id description name ski_difficulty]

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
end
