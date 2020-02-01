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

    it "sends first instance by id" do
      merchant = create(:merchant)
      merchants = create_list(:merchant, 10)

      get "/api/v1/merchants/find?id=#{merchant.id}"
      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)["data"]
      expect(merchant_info["attributes"]["id"]).to eq(merchant.id)
    end

    it "sends all instances by id" do
      merchant = create(:merchant)
      merchants = create_list(:merchant, 10)

      get "/api/v1/merchants/find_all?id=#{merchant.id}"
      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)["data"]
      expect(merchant_info.count).to eq(1)
    end

    it "sends first instance by name" do
      merchant = create(:merchant)
      merchants = create_list(:merchant, 10)

      get "/api/v1/merchants/find?name=#{merchant.name}"
      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)["data"]
      expect(merchant_info["attributes"]["id"]).to eq(merchant.id)
    end

    it "sends all instances by name" do
      merchant = create(:merchant)
      merchants = create_list(:merchant, 10)

      get "/api/v1/merchants/find_all?name=#{merchant.name}"
      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)["data"]
      expect(merchant_info.count).to eq(11)
    end

    xit "sends first instance by created_at" do
      merchant = create(:merchant)
      merchants = create_list(:merchant, 10)

      get "/api/v1/merchants/find?created_at=#{merchant.created_at}"
      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)["data"]
      expect(merchant_info["attributes"]["id"]).to eq(merchant.id)
    end

    xit "sends all instances by created_at" do
      merchant = create(:merchant)
      merchants = create_list(:merchant, 10)

      get "/api/v1/merchants/find_all?created_at=#{merchant.created_at}"
      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)["data"]
      expect(merchant_info.count).to eq(11)
    end

    xit "sends first instance by updated_at" do
      merchant = create(:merchant)
      merchants = create_list(:merchant, 10)

      get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"
      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)["data"]
      expect(merchant_info["attributes"]["id"]).to eq(merchant.id)
    end

    xit "sends all instances by updated_at" do
      merchant = create(:merchant)
      merchants = create_list(:merchant, 10)

      get "/api/v1/merchants/find_all?updated_at=#{merchant.updated_at}"
      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)["data"]
      expect(merchant_info.count).to eq(11)
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
