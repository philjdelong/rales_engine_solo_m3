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

    it "sends first instance by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find?id=#{invoice.id}"
      expect(response).to be_successful

      invoice_info = JSON.parse(response.body)["data"]
      expect(invoice_info["attributes"]["id"]).to eq(invoice.id)
    end

    it "sends all instances by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find_all?id=#{invoice.id}"
      expect(response).to be_successful

      invoice_info = JSON.parse(response.body)["data"]
      expect(invoice_info.count).to eq(1)
    end

    it "sends first instance by customer_id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice.id)
    end

    it "sends all instances by customer_id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find_all?customer_id=#{invoice.customer_id}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(11)
    end

    it "sends first instance by merchant_id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice.id)
    end

    it "sends all instances by merchant_id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find_all?merchant_id=#{invoice.merchant_id}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(11)
    end

    it "sends first instance by status" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find?status=#{invoice.status}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice.id)
    end

    it "sends all instances by status" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/find_all?status=#{invoice.status}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(11)
    end

    it "sends first instance by created_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: "2020-02-02 00:35:22 UTC")
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id, created_at: "2020-02-02 00:35:22 UTC")

      get "/api/v1/invoices/find?created_at=#{invoice.created_at}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice.id)
    end

    it "sends all instances by created_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: "2020-02-02 00:35:22 UTC")
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id, created_at: "2020-02-02 00:35:22 UTC")

      get "/api/v1/invoices/find_all?created_at=#{invoice.created_at}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(11)
    end

    it "sends first instance by updated_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, updated_at: "2020-02-02 00:35:22 UTC")
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id, updated_at: "2020-02-02 00:35:22 UTC")

      get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice.id)
    end

    it "sends all instances by updated_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, updated_at: "2020-02-02 00:35:22 UTC")
      invoices = create_list(:invoice, 10, merchant_id: merchant.id, customer_id: customer.id, updated_at: "2020-02-02 00:35:22 UTC")

      get "/api/v1/invoices/find_all?updated_at=#{invoice.updated_at}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(11)
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

    it "sends a list of all invoice_items" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      create_list(:item, 10, merchant_id: merchant.id)
      create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"
      expect(response).to be_successful

      invoice_items_info = JSON.parse(response.body)['data']
      expect(invoice_items_info.count).to eq(10)
    end

    it "sends the merchant and sends the customer" do
      merchant = create(:merchant, id: 1)
      customer = create(:customer, id: 1)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/invoices/#{invoice.id}/merchant"
      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)["data"]
      expect(merchant_info["attributes"]["id"]).to eq(merchant.id)

      get "/api/v1/invoices/#{invoice.id}/customer"
      expect(response).to be_successful

      customer_info = JSON.parse(response.body)["data"]
      expect(customer_info["attributes"]["id"]).to eq(customer.id)
    end
  end
end
