FactoryBot.define do
  factory :invoice do
    status { "Shipped" }
    merchant_id { 1 }
    customer_id { 1 }
  end
end
