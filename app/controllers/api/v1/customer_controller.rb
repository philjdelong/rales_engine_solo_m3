class Api::V1::CustomerController < ApplicationController

  def index
    invoice = Invoice.find(params[:invoice_id])
    customer = invoice.customer
    render json: CustomerSerializer.new(customer)
  end
end
