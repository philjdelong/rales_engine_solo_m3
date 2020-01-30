class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def unit_price
    (self["unit_price"]/100).round(2)
  end
end
