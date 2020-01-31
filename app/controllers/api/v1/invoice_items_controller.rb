class Api::V1::InvoiceItemsController < ApplicationController

  def index
    if params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      invoice_items = invoice.invoice_items
    elsif params[:item_id]
      item = Item.find(params[:item_id])
      invoice_items = item.invoice_items
    else
      invoice_items = InvoiceItem.all
    end
    render json: InvoiceItemSerializer.new(invoice_items)
  end

  def show
    invoice_item = InvoiceItem.find(params[:id])
    render json: InvoiceItemSerializer.new(invoice_item)
  end
end
