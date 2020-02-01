class Api::V1::Merchants::FindController < ApplicationController

  def show
    item = Merchant.find_by(request.query_parameters)
    render json: MerchantSerializer.new(item)
  end

  def index
    items = Merchant.where(request.query_parameters)
    render json: MerchantSerializer.new(items)
  end
end
