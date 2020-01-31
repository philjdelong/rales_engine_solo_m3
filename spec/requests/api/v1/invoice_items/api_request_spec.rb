require 'rails_helper'

RSpec.describe "Invoice Items API" do
  describe "endpoints" do
    it "sends a list of all invoice_items" do
      merchant = create(:merchant, id: 1)
      item = create(:item, id: 1, merchant_id: merchant.id)
      customer = create(:customer, id: 1)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(10)
    end

    it "sends a single invoice_item" do
      merchant = create(:merchant, id: 1)
      item = create(:item, id: 1, merchant_id: merchant.id)
      customer = create(:customer, id: 1)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/#{invoice_item.id}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
    end
  end

  describe "relationships" do
    it "send the associated invoice" do
      merchant = create(:merchant, id: 1)
      item = create(:item, id: 1, merchant_id: merchant.id)
      customer = create(:customer, id: 1)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"
      expect(response).to be_successful

      invoice_info = JSON.parse(response.body)["data"]
      expect(invoice_info["attributes"]["id"]).to eq(invoice.id)
    end

    it "send the associated item" do
      merchant = create(:merchant, id: 1)
      item = create(:item, id: 1, merchant_id: merchant.id)
      customer = create(:customer, id: 1)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info["attributes"]["id"]).to eq(item.id)
    end
  end
end
