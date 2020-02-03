class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def unit_price
    (self["unit_price"]/100).round(2)
  end

  def best_day
    Invoice.
      select('invoices.*, invoices.created_at, SUM(invoice_items.quantity) AS total_items').
      joins(invoices: :transactions).
      merge(Transaction.successful).
      where("#{self.id} = invoice_items.item_id").
      group('invoices.id, invoices.created_at').
      order('total_items DESC').
      limit(1).first
    #
    # Date.parse(item[:created_at])
  end
end
