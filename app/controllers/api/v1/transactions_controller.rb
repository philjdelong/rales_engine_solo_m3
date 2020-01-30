class Api::V1::TransactionsController < ApplicationController

  def index
    customer = Customer.find(params[:customer_id])
    transactions = customer.transactions
    render json: TransactionSerializer.new(transactions)
  end
end
