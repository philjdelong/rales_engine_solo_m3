class Api::V1::Transactions::FindController < ApplicationController

  def show
    merchant = Transaction.find_by(request.query_parameters)
    render json: TransactionSerializer.new(merchant)
  end

  def index
    merchants = Transaction.where(request.query_parameters)
    render json: TransactionSerializer.new(merchants)
  end
end
