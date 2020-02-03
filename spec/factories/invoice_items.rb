FactoryBot.define do
  factory :invoice_item do
    quantity { 1 }
    unit_price { 1.25 }
    item_id { 1 }
    invoice_id { 1 }
  end
end
