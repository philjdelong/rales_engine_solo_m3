class Api::V1::ItemsController < ApplicationController

  def index
    if params[:merchant_id]
      merchant = Merchant.find(params[:merchant_id])
      items = merchant.items
    elsif params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      items = invoice.items
    else
      items = Item.all
    end
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end
end
