FactoryBot.define do
  factory :invoice do
    status { "Shipped" }
    merchant_id { 1 }
    customer { nil }
  end
end
