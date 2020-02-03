class Api::V1::Merchants::FindController < ApplicationController

  def show
    merchant = Merchant.find_by(merchant_info)
    render json: MerchantSerializer.new(merchant)
  end

  def index
    merchants = Merchant.where(merchant_info)
    render json: MerchantSerializer.new(merchants)
  end

  private
    def merchant_info
      params.permit(:id, :name, :created_at, :updated_at)
    end
end
