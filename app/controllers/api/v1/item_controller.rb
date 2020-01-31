class Api::V1::ItemController < ApplicationController

  def index
    if params[:invoice_item_id]
      invoice_item = InvoiceItem.find(params[:invoice_item_id])
      item = invoice_item.item
    end
    render json: ItemSerializer.new(item)
  end
end
