class Api::V1::Items::FindController < ApplicationController

  def show
    if params["merchant_id"]
      item = Item.order(:id).find_by(item_info)
    else
      item = Item.find_by(item_info)
    end
    render json: ItemSerializer.new(item)
  end

  def index
    items = Item.where(item_info)
    render json: ItemSerializer.new(items)
  end

  private
    def item_info
      params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
    end
end
