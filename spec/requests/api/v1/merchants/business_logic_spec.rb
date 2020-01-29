require 'rails_helper'

RSpec.describe "Merchants API" do
  it "sends the top customer" do
    merchant = create(:merchant, id: 1)
    customer_1 = create(:customer, id: 1)
    customer_2 = create(:customer, id: 2)
    customer_3 = create(:customer, id: 3)
    invoice_1 = create(:invoice, customer_id: 1, merchant_id: 1)
    invoice_2 = create(:invoice, customer_id: 1, merchant_id: 1)
    invoice_3 = create(:invoice, customer_id: 1, merchant_id: 1)
    invoice_4 = create(:invoice, customer_id: 2, merchant_id: 1)
    invoice_5 = create(:invoice, customer_id: 2, merchant_id: 1)
    invoice_6 = create(:invoice, customer_id: 3, merchant_id: 1)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"
    expect(response).to be_successful

    favorite_customer = JSON.parse(response.body)["data"]

    expect(customers["id"]).to eq(1)
  end
end
