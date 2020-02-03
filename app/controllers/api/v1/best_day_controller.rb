class Api::V1::BestDayController < ApplicationController

  def index
    item = Item.find(params[:item_id])
    best_day = item.best_day
    render json: DateSerializer.new(best_day)
  end
end
