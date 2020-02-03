require 'rails_helper'

RSpec.describe "Items API" do
  describe "business logic" do
    xit "sends the best day associated with an item" do
      merchant_1 = create(:merchant, id: 1)
      merchant_2 = create(:merchant, id: 2)
      customer_1 = create(:customer, id: 1)
      customer_2 = create(:customer, id: 2)
      customer_3 = create(:customer, id: 3)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_1.id)
      invoice_1 = create(:invoice, id: 1, customer_id: 1, merchant_id: 1, created_at: "Sun, 02 Feb 2012 19:30:08 UTC +00:00")
      invoice_2 = create(:invoice, id: 2, customer_id: 2, merchant_id: 1, created_at: "Sun, 02 Feb 2012 19:30:08 UTC +00:00")
      invoice_3 = create(:invoice, id: 3, customer_id: 3, merchant_id: 2, created_at: "Sun, 02 Feb 2015 19:30:08 UTC +00:00")
      invoice_4 = create(:invoice, id: 4, customer_id: 3, merchant_id: 2, created_at: "Sun, 02 Feb 2015 19:30:08 UTC +00:00")
      invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id)
      invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id)
      transaction_1 = create(:transaction, invoice_id: 1, result: "success")
      transaction_2 = create(:transaction, invoice_id: 1, result: "success")
      transaction_3 = create(:transaction, invoice_id: 1, result: "success")
      transaction_4 = create(:transaction, invoice_id: 1, result: "success")
      transaction_5 = create(:transaction, invoice_id: 2, result: "success")

      get "/api/v1/items/#{item_1.id}/best_day"
      expect(response).to be_successful

      best_day = JSON.parse(response.body)["data"]
      expect(item_1.best_day).to eq(Date.parse(invoice_1.created_at.to_s).to_s)
    end
  end
end
