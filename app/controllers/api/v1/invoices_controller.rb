class Api::V1::InvoicesController < ApplicationController

  def index
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      invoices = customer.invoices
    else
      invoices = Invoice.all
    end
    render json: InvoiceSerializer.new(invoices)
  end

  def show
    invoice = Invoice.find(params[:id])
    render json: InvoiceSerializer.new(invoice)
  end
end
