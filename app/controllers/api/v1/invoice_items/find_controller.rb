class Api::V1::InvoiceItems::FindController < ApplicationController

  def show
    customer = InvoiceItem.find_by(request.query_parameters)
    render json: InvoiceItemSerializer.new(customer)
  end

  def index
    customers = InvoiceItem.where(request.query_parameters)
    render json: InvoiceItemSerializer.new(customers)
  end
end
