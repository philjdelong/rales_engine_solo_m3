require 'rails_helper'

RSpec.describe "Customers API" do
  describe "endpoints" do
    it "sends a list of customers" do
      create_list(:customer, 10)

      get "/api/v1/customers"
      expect(response).to be_successful

      customers = JSON.parse(response.body)

      expect(customers["data"].count).to eq(10)
    end

    it "sends a single customer" do
      customer = create(:customer, id: 5)

      get "/api/v1/customers/#{customer.id}"
      expect(response).to be_successful

      customer_info = JSON.parse(response.body)
      expect(customer_info["data"]["attributes"]["id"]).to eq(customer.id)
    end

    it "sends first instance by id" do
      customer = create(:customer)
      customers = create_list(:customer, 10)

      get "/api/v1/customers/find?id=#{customer.id}"
      expect(response).to be_successful

      customer_info = JSON.parse(response.body)["data"]
      expect(customer_info["attributes"]["id"]).to eq(customer.id)
    end

    it "sends first instance by first_name" do
      customer = create(:customer)

      get "/api/v1/customers/find?first_name=#{customer.first_name}"
      expect(response).to be_successful

      customer_info = JSON.parse(response.body)["data"]
      expect(customer_info["attributes"]["id"]).to eq(customer.id)
    end

    it "sends first instance by last_name" do
      customer = create(:customer)

      get "/api/v1/customers/find?last_name=#{customer.last_name}"
      expect(response).to be_successful

      customer_info = JSON.parse(response.body)["data"]
      expect(customer_info["attributes"]["id"]).to eq(customer.id)
    end

    xit "sends first instance by created_at" do
      customer = create(:customer)

      get "/api/v1/customers/find?created_at=#{customer.created_at}"
      expect(response).to be_successful

      customer_info = JSON.parse(response.body)["data"]

      expect(customer_info["attributes"]["id"]).to eq(customer.id)
    end

    xit "sends first instance by updated_at" do
      customer = create(:customer)

      get "/api/v1/customers/find?updated_at=#{customer.updated_at}"
      expect(response).to be_successful

      customer_info = JSON.parse(response.body)["data"]
      expect(customer_info["attributes"]["id"]).to eq(customer.id)
    end

    it "sends all instances by id" do
      customer_1 = create(:customer, id: 1)
      create_list(:customer, 12)

      get "/api/v1/customers/find_all?id=#{customer_1["id"]}"
      expect(response).to be_successful

      customers = JSON.parse(response.body)["data"]
      expect(customers.count).to eq(1)
    end

    it "sends all instances by first_name" do
      customer_1 = create(:customer, id: 1)
      create_list(:customer, 12)

      get "/api/v1/customers/find_all?first_name=#{customer_1["first_name"]}"
      expect(response).to be_successful

      customer_info = JSON.parse(response.body)["data"]
      expect(customer_info.count).to eq(13)
    end

    it "sends all instances by last_name" do
      customer_1 = create(:customer, id: 1)
      create_list(:customer, 12)

      get "/api/v1/customers/find_all?last_name=#{customer_1['last_name']}"
      expect(response).to be_successful

      customer_info = JSON.parse(response.body)["data"]
      expect(customer_info.count).to eq(13)
    end

    xit "sends all instances by created_at" do
      create_list(:customer, 12)

      get "/api/v1/customers/find_all?created_at=#{customer["created_at"]}"
      expect(response).to be_successful

      customer_info = JSON.parse(response.body)["data"]
      expect(customer_info.count).to eq(12)
    end

    xit "sends all instances by updated_at" do
      create_list(:customer, 12)

      get "/api/v1/customers/find_all?updated_at=#{customer["updated_at"]}"
      expect(response).to be_successful

      customer_info = JSON.parse(response.body)["data"]
      expect(customer_info.count).to eq(12)
    end
  end

  describe "relationship endpoints" do
    it "sends a list of customers invoices" do
      merchant = create(:merchant, id: 1)
      customer_1 = create(:customer, id: 1)
      customer_2 = create(:customer, id: 2)
      invoice_1 = create(:invoice, customer_id: 1, merchant_id: 1)
      invoice_2 = create(:invoice, customer_id: 1, merchant_id: 1)
      invoice_3 = create(:invoice, customer_id: 1, merchant_id: 1)
      invoice_4 = create(:invoice, customer_id: 2, merchant_id: 1)

      get "/api/v1/customers/#{customer_1.id}/invoices"
      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]

      expect(invoices.count).to eq(3)
    end

    it "send a list of customer transactions" do
      merchant = create(:merchant, id: 1)
      customer_1 = create(:customer, id: 1)
      invoice_1 = create(:invoice, id: 1, merchant_id: 1, customer_id: 1)
      transaction_1 = create(:transaction, invoice_id: 1)
      transaction_2 = create(:transaction, invoice_id: 1)
      transaction_3 = create(:transaction, invoice_id: 1)

      customer_2 = create(:customer, id: 2)
      invoice_2 = create(:invoice, id: 2, merchant_id: 1, customer_id: 2)
      transaction_4 = create(:transaction, invoice_id: 2)

      get "/api/v1/customers/#{customer_1.id}/transactions"
      expect(response).to be_successful

      transactions = JSON.parse(response.body)['data']
      expect(transactions.count).to eq(3)
    end
  end
end
