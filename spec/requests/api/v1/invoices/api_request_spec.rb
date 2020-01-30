require 'rails_helper'

RSpec.describe "Invoices API" do
  describe "endpoints" do
    it "sends a list of all invoices" do
      merchant = create(:merchant, id: 1)
      item = create(:item, id: 1, merchant_id: merchant.id)
      customer = create(:customer, id: 1)
      create_list(:invoice, 20, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices"
      expect(response).to be_successful

      invoice_info = JSON.parse(response.body)["data"]
      expect(invoice_info.count).to eq(20)
    end

    it "sends a single invoice" do
      merchant = create(:merchant, id: 1)
      item = create(:item, id: 1, merchant_id: merchant.id)
      customer = create(:customer, id: 1)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/#{invoice.id}"
      expect(response).to be_successful

      invoice_info = JSON.parse(response.body)["data"]
      expect(invoice_info["attributes"]["id"]).to eq(invoice.id)
    end
  end

  describe "relationships" do
    it "sends a list of all transactions" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      create_list(:transaction, 10, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/transactions"
      expect(response).to be_successful

      transactions_info = JSON.parse(response.body)['data']
      expect(transactions_info.count).to eq(10)
    end
    it "sends a list of all items" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      create_list(:item, 10, merchant_id: merchant.id)
      create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoices/#{invoice.id}/items"
      expect(response).to be_successful

      items_info = JSON.parse(response.body)['data']
      expect(items_info.count).to eq(10)
    end
  end
end
