class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_customer
    Customer.
      select('customers.*, COUNT(transactions.id) AS total_successful_transactions').
      joins(invoices: :transactions).
      merge(Transaction.successful).
      where("#{self.id} = invoices.merchant_id").
      group('customers.id').
      order('total_successful_transactions DESC').
      limit(1).first
  end
end
