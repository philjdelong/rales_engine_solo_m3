class Api::V1::MerchantController < ApplicationController

  def index
    invoice = Invoice.find(params[:invoice_id])
    merchant = invoice.merchant
    render json: MerchantSerializer.new(merchant)
  end
end
