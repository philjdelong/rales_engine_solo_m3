require 'rails_helper'

RSpec.describe "Merchants API" do
  describe "endpoints" do
    it "sends a list of merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants"
      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expect(merchants["data"].count).to eq(3)
    end

    it "sends a single merchant" do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"
      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)
      expect(merchant_info["data"]["attributes"]["id"]).to eq(merchant.id)
    end
  end

  describe "relationships" do
    it "sends a list of merchants items" do
      merchant = create(:merchant)
      merchant_2 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      item_3 = create(:item, merchant_id: merchant_2.id)

      get "/api/v1/merchants/#{merchant.id}/items"
      expect(response).to be_successful

      merchant_items = JSON.parse(response.body)["data"]
      expect(merchant_items.count).to eq(2)
    end

    it "sends a list of merchants invoices" do
      customer = create(:customer)
      merchant = create(:merchant)
      merchant_2 = create(:merchant)
      invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_3 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)

      get "/api/v1/merchants/#{merchant.id}/invoices"
      expect(response).to be_successful

      merchant_invoices = JSON.parse(response.body)["data"]
      expect(merchant_invoices.count).to eq(2)
    end
  end
end
