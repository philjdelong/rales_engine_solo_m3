class Api::V1::ItemsController < ApplicationController

  def index
    if :merchant_id
      merchant = Merchant.find(params[:merchant_id])
      items = merchant.items
    else
      items = Item.all
    end
    render json: ItemSerializer.new(items)
  end
end
