class LineCollection
  DATA_PATH = Rails.root.join('data', 'off-pistes.json')
  attr_reader :lines

  delegate :count, :first, to: :lines

  def search(search_term)
    filtered_lines = lines.select {|l| l.name =~ /#{Regexp.escape(search_term)}/i }
    self.class.new(filtered_lines)
  end

  def sort(key = :name, direction = :asc)
    sorted_lines = lines.sort_by {|l| l.send(key) }.tap do |sort_result|
      sort_result.reverse! if direction == :desc
    end
    self.class.new(sorted_lines)
  end

  def initialize(lines = nil)
    @lines = lines || all_lines
  end

  private
  def all_lines
    @all_lines ||= JSON.parse(File.read(DATA_PATH)).map do |line_hash|
      Line.new(line_hash.symbolize_keys)
    end
  end
end
