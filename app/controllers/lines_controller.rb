class LinesController < ApplicationController
  include ActionController::MimeResponds

  helper_method :difficulty_filter, :name_search, :sort_direction, :sort_key

  def index
    @lines = Line.search(:name, line_params[:name_search])
    .search(:ski_difficulty, line_params[:difficulty_filter])
    .sort(line_params[:sort_key], line_params[:sort_direction]).lines

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @lines }
    end
  end

  def show
    @line = Line.search(:id, line_params[:id]).first
    if @line.blank?
      head :not_found and return
    end

    respond_to do |format|
      format.json { render json: render_to_string(partial: 'line_canvas.html.erb', locals: { line: @line }) }
      format.html { render partial: 'line_canvas', locals: { line: @line } }
    end
  end

  private

  def difficulty_filter
    line_params[:difficulty_filter]
  end

  def name_search
    line_params[:name_search]
  end

  def sort_direction
    line_params[:sort_direction]
  end

  def sort_key
    line_params[:sort_key]
  end

  def line_params
    params.permit(:id, :name_search, :difficulty_filter, :sort_key, :sort_direction)
  end
end
