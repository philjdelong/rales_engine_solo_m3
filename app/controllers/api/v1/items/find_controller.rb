class Api::V1::Items::FindController < ApplicationController

  def show
    if params["merchant_id"]
      item = Item.order(:id).find_by(request.query_parameters)
    else
      item = Item.find_by(request.query_parameters)
    end
    render json: ItemSerializer.new(item)
  end

  def index
    items = Item.where(request.query_parameters)
    render json: ItemSerializer.new(items)
  end
end
