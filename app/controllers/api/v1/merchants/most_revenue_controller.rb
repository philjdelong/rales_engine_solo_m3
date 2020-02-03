class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    Merchant.most_revenue.limit(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end
