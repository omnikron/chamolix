class LineCollection
  DATA_PATH = Rails.root.join('data', 'off-pistes.json')
  attr_reader :lines

  delegate :count, :first, to: :lines

  def initialize(lines = nil)
    @lines = lines || all_lines
  end

  def search(key, search_term = '')
    return self unless search_term.present? && key.present? && key.in?(Line::PROPERTIES)

    filtered_lines = lines.select do |l|
      l.send(key).to_s =~ /#{Regexp.escape(search_term)}/i
    end

    self.class.new(filtered_lines)
  end

  def sort(key = :name, direction = :asc)
    return self unless key.present?

    sorted_lines = lines.sort_by {|l| l.send(key) }.tap do |sort_result|
      sort_result.reverse! if direction&.to_sym == :desc
    end

    self.class.new(sorted_lines)
  end

  private
  def all_lines
    JSON.parse(File.read(DATA_PATH)).map do |line_hash|
      Line.new(line_hash.symbolize_keys)
    end
  end
end
