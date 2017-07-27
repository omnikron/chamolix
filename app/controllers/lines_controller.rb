class LinesController < ApplicationController
  def index
    render json: Line.search(:name, input[:name_search])
    .search(:ski_difficulty, input[:difficulty_filter])
    .sort(input[:sort_key], input[:sort_direction])
  end

  private
  def input
    params.permit(:name_search, :difficulty_filter, :sort_key, :sort_direction)
  end
end
