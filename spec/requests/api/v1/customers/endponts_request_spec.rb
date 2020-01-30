require 'rails_helper'

RSpec.describe "Merchants API" do
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

    it "can find first instance by id" do
      customer = create(:customer, id:10)
      customers = create_list(:customer, 10)

      get "/api/v1/customers/find?id=#{customer['id']}"
      customer_info = JSON.parse(response.body)
      expect(customer_info["data"]["attributes"]["id"]).to eq(10)
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
  end
end
