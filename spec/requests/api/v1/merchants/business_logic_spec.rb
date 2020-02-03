require 'rails_helper'

RSpec.describe "Merchants API" do
  describe "business logic" do
    it "sends the top customer" do
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

    xit "send the top merchant by revenue" do
      merchant_1 = create(:merchant, id: 1)
      merchant_2 = create(:merchant, id: 2)
      merchant_3 = create(:merchant, id: 3)

      item_1 = create(:item, id: 1, merchant_id: 1, unit_price: 10)
      item_2 = create(:item, id: 2, merchant_id: 1, unit_price: 15)
      item_3 = create(:item, id: 3, merchant_id: 2, unit_price: 20)

      customer_1 = create(:customer, id: 1)
      customer_2 = create(:customer, id: 2)
      customer_3 = create(:customer, id: 3)

      invoice_1 = create(:invoice, id: 1, customer_id: 1, merchant_id: 1)
      invoice_2 = create(:invoice, id: 2, customer_id: 2, merchant_id: 1)
      invoice_3 = create(:invoice, id: 3, customer_id: 3, merchant_id: 2)

      invoice_item_1 = create(:invoice_item, id: 1, invoice_id: 1, item_id: 1, quantity: 0, unit_price: 10)
      invoice_item_2 = create(:invoice_item, id: 2, invoice_id: 2, item_id: 1, quantity: 6, unit_price: 10)
      invoice_item_3 = create(:invoice_item, id: 3, invoice_id: 3, item_id: 3, quantity: 2, unit_price: 20)

      transaction_1 = create(:transaction, invoice_id: 1, result: "success")
      transaction_2 = create(:transaction, invoice_id: 3, result: "success")

      get "/api/v1/merchants/most_revenue?quantity=1"
      expect(response).to be_successful

      info = JSON.parse(response.body)["data"].first
      expect(info["attributes"]["id"]).to eq(merchant_1.id)

      get "/api/v1/merchants/most_revenue?quantity=3"
      expect(response).to be_successful

      most_revenue = JSON.parse(response.body)["data"]
      expect(most_revenue.count).to eq(3)
    end
  end
end
