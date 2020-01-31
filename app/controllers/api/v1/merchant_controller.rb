class Api::V1::MerchantController < ApplicationController

  def index
    if params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      merchant = invoice.merchant
    elsif params[:item_id]
      item = Item.find(params[:item_id])
      merchant = item.merchant
    end
    render json: MerchantSerializer.new(merchant)
  end
end
