require 'rails_helper'

RSpec.describe "Transactions API" do
  describe "endpoints" do
    it "sends a list of transactions" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction = create(:transaction, invoice_id: invoice.id)
      transactions = create_list(:transaction, 10, invoice_id: invoice.id)

      get "/api/v1/transactions"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]
      expect(transaction.count).to eq(11)
    end

    it "sends individual transactions" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction = create(:transaction, invoice_id: invoice.id)
      transactions = create_list(:transaction, 10, invoice_id: invoice.id)

      get "/api/v1/transactions/#{transaction.id}"
      expect(response).to be_successful

      transaction_invoice = JSON.parse(response.body)["data"]
      expect(transaction_invoice["attributes"]["id"]).to eq(transaction.id)
    end

    it "sends first instance by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction = create(:transaction, invoice_id: invoice.id)
      transactions = create_list(:transaction, 10, invoice_id: invoice.id)

      get "/api/v1/transactions/find?id=#{transaction.id}"
      expect(response).to be_successful

      transaction_info = JSON.parse(response.body)["data"]
      expect(transaction_info["attributes"]["id"]).to eq(transaction.id)
    end

    it "sends all instances by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction = create(:transaction, invoice_id: invoice.id)
      transactions = create_list(:transaction, 10, invoice_id: invoice.id)

      get "/api/v1/transactions/find_all?id=#{transaction.id}"
      expect(response).to be_successful

      transaction_info = JSON.parse(response.body)["data"]
      expect(transaction_info.count).to eq(1)
    end

    it "sends first instance by invoice_id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction = create(:transaction, invoice_id: invoice.id)
      transactions = create_list(:transaction, 10, invoice_id: invoice.id)

      get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"
      expect(response).to be_successful

      transaction_info = JSON.parse(response.body)["data"]
      expect(transaction_info["attributes"]["id"]).to eq(transaction.id)
    end

    it "sends all instances by invoice_id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction = create(:transaction, invoice_id: invoice.id)
      transactions = create_list(:transaction, 10, invoice_id: invoice.id)

      get "/api/v1/transactions/find_all?invoice_id=#{transaction.invoice_id}"
      expect(response).to be_successful

      transaction_info = JSON.parse(response.body)["data"]
      expect(transaction_info.count).to eq(11)
    end
  end

  describe "relationships" do
    it "sends the associated invoice" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/#{transaction.id}/invoice"
      expect(response).to be_successful

      transaction_invoice = JSON.parse(response.body)["data"]
      expect(transaction_invoice["attributes"]["id"]).to eq(invoice.id)
    end
  end
end
