class LinesController < ApplicationController
  def index
    @lines = Line.search(:name, line_params[:name_search])
    .search(:ski_difficulty, line_params[:difficulty_filter])
    .sort(line_params[:sort_key], line_params[:sort_direction])

    render json: @lines
  end

  def show
    @line = Line.search(:id, line_params[:id]).first
    if @line.blank?
      head :not_found and return
    end
    render json: render_to_string('line_canvas', locals: { line: @line })
  end

  private
  def line_params
    params.permit(:id, :name_search, :difficulty_filter, :sort_key, :sort_direction)
  end
end
