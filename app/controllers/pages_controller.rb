class PagesController < ApplicationController

  def index

    @boards = Board.where(user_id: current_user.id)
    
    @board = Board.new()

    weight_hash = FetchFitbitInfoService.fetch(FetchFitbitInfoService.apis[:weight])
    @weight_data = weight_hash[:weight]
    @min_weight = weight_hash[:min]
    @max_weight = weight_hash[:max]

    @summary_hash = FetchFitbitInfoService.fetch(FetchFitbitInfoService.apis[:summary])

  end

  def sandbox

    weight_hash = FetchFitbitInfoService.fetch(FetchFitbitInfoService.apis[:weight])
    @weight_data = weight_hash[:weight]
    @min_weight = weight_hash[:min]
    @max_weight = weight_hash[:max]

    summary_hash = FetchFitbitInfoService.fetch(FetchFitbitInfoService.apis[:summary])
    @goal_calories = summary_hash[:goal_calories_out]
    @current_calories = summary_hash[:current_calories_out]
    @goal_steps = summary_hash[:goal_steps]
    @current_steps = summary_hash[:current_steps]

  end

end
