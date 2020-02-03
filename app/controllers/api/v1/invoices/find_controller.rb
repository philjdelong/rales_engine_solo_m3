class Api::V1::Invoices::FindController < ApplicationController

  def show
    invoice = Invoice.find_by(invoice_info)
    render json: InvoiceSerializer.new(invoice)
  end

  def index
    invoices = Invoice.where(invoice_info)
    render json: InvoiceSerializer.new(invoices)
  end

  private
    def invoice_info
      params.permit(:id, :status, :merchant_id, :customer_id, :created_at, :updated_at)
    end
end
