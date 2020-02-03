class Api::V1::Transactions::FindController < ApplicationController

  def show
    transaction = Transaction.find_by(transaction_info)
    render json: TransactionSerializer.new(transaction)
  end

  def index
    transactions = Transaction.where(transaction_info)
    render json: TransactionSerializer.new(transactions)
  end

  private
    def transaction_info
      params.permit(:id, :credit_card_number, :credit_card_expiration_date, :result, :invoice_id, :created_at, :updated_at)
    end
end
