class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def unit_price
    (self["unit_price"]/100).round(2)
  end
end
