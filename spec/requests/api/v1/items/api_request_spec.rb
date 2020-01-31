require 'rails_helper'

RSpec.describe "Items API" do
  describe "endpoints" do
    it "sends a list of items" do
      merchant = create(:merchant)
      create_list(:item, 12, merchant_id: merchant.id)

      get "/api/v1/items"
      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(12)
    end

    it "sends a single item" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)
      expect(item_info["data"]["attributes"]["id"]).to eq(item.id)
    end
  end

  describe "relationships" do
    it "sends the merchant" do
      merchant = create(:merchant, id: 1)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchant"
      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)["data"]
      expect(merchant_info["attributes"]["id"]).to eq(merchant.id)
    end

    it "sends a list of invoice_items" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/items/#{item.id}/invoice_items"
      expect(response).to be_successful

      invoice_items_info = JSON.parse(response.body)['data']
      expect(invoice_items_info.count).to eq(10)
    end
  end
end
