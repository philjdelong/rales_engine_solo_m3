class Api::V1::InvoiceItems::FindController < ApplicationController

  def show
    if params[:unit_price]
      invoice_item = InvoiceItem.find_by(invoice_item_info)
    end
    invoice_item = InvoiceItem.find_by(invoice_item_info)
    render json: InvoiceItemSerializer.new(invoice_item)
  end

  def index
    if params[:unit_price]
      invoice_item = InvoiceItem.find_by(invoice_item_info)
    end
    invoice_items = InvoiceItem.where(invoice_item_info)
    render json: InvoiceItemSerializer.new(invoice_items)
  end

  private
    def invoice_item_info
      params.permit(:id, :quantity, :unit_price, :item_id, :invoice_id, :created_at, :updated_at)
    end
end
