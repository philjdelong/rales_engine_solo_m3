require 'rails_helper'

RSpec.describe "Merchants API" do
  xit "sends the top customer" do
    merchant_1 = create(:merchant, id: 1)
    merchant_2 = create(:merchant, id: 2)
    customer_1 = create(:customer, id: 1)
    customer_2 = create(:customer, id: 2)
    customer_3 = create(:customer, id: 3)
    invoice_1 = create(:invoice, id: 1, customer_id: 1, merchant_id: 1)
    invoice_2 = create(:invoice, id: 2, customer_id: 2, merchant_id: 1)
    invoice_3 = create(:invoice, id: 3, customer_id: 3, merchant_id: 2)
    invoice_4 = create(:invoice, id: 4, customer_id: 3, merchant_id: 2)
    transaction_1 = create(:transaction, invoice_id: 1, result: "failed")
    transaction_2 = create(:transaction, invoice_id: 1, result: "failed")
    transaction_3 = create(:transaction, invoice_id: 1, result: "failed")
    transaction_4 = create(:transaction, invoice_id: 1, result: "success")
    transaction_5 = create(:transaction, invoice_id: 1, result: "success")
    transaction_6 = create(:transaction, invoice_id: 2, result: "success")
    transaction_7 = create(:transaction, invoice_id: 2, result: "success")
    transaction_8 = create(:transaction, invoice_id: 2, result: "success")
    transaction_9 = create(:transaction, invoice_id: 3, result: "success")
    transaction_10 = create(:transaction, invoice_id: 3, result: "success")
    transaction_11 = create(:transaction, invoice_id: 3, result: "success")
    transaction_12 = create(:transaction, invoice_id: 3, result: "success")
    transaction_13 = create(:transaction, invoice_id: 4, result: "success")
    transaction_14 = create(:transaction, invoice_id: 4, result: "success")

    get "/api/v1/merchants/#{merchant_1.id}/favorite_customer"
    expect(response).to be_successful

    favorite_customer = JSON.parse(response.body)["data"]
    expect(favorite_customer["attributes"]["id"]).to eq(2)

    get "/api/v1/merchants/#{merchant_2.id}/favorite_customer"
    expect(response).to be_successful

    favorite_customer = JSON.parse(response.body)["data"]
    expect(favorite_customer["attributes"]["id"]).to eq(3)
  end
end
