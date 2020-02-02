class Customer < ApplicationRecord

  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    Merchant.
      select('merchants.*, COUNT(transactions.id) AS total_successful_transactions').
      joins(invoices: :transactions).
      merge(Transaction.successful).
      where("#{self.id} = invoices.customer_id").
      group('merchants.id').
      order('total_successful_transactions DESC').
      limit(1).first
  end
end
