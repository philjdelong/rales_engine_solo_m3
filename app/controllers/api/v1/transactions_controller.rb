class Api::V1::TransactionsController < ApplicationController

  def index
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      transactions = customer.transactions
    elsif params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      transactions = invoice.transactions
    else
      transactions = Transaction.all
    end
    render json: TransactionSerializer.new(transactions)
  end

  def show
    transaction = Transaction.find(params[:id])
    render json: TransactionSerializer.new(transaction)
  end
end
