class Api::V1::InvoiceController < ApplicationController

  def index
    if params[:invoice_item_id]
      invoice_item = InvoiceItem.find(params[:invoice_item_id])
      invoice = invoice_item.invoice
    elsif params[:transaction_id]
      transaction = Transaction.find(params[:transaction_id])
      invoice = transaction.invoice
    end
    render json: InvoiceSerializer.new(invoice)
  end
end
