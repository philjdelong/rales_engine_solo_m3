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

    it "sends first instance by id" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      items = create_list(:item, 10, merchant_id: merchant.id)

      get "/api/v1/items/find?id=#{item.id}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info["attributes"]["id"]).to eq(item.id)
    end

    it "sends all instances by id" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      items = create_list(:item, 10, merchant_id: merchant.id)

      get "/api/v1/items/find_all?id=#{item.id}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info.count).to eq(1)
    end

    it "sends first instance by name" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      items = create_list(:item, 10, merchant_id: merchant.id)

      get "/api/v1/items/find?name=#{item.name}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info["attributes"]["id"]).to eq(item.id)
    end

    it "sends all instances by name" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      items = create_list(:item, 10, merchant_id: merchant.id)

      get "/api/v1/items/find_all?name=#{item.name}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info.count).to eq(11)
    end

    it "sends first instance by description" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      items = create_list(:item, 10, merchant_id: merchant.id)

      get "/api/v1/items/find?description=#{item.description}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info["attributes"]["id"]).to eq(item.id)
    end

    it "sends all instances by description" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      items = create_list(:item, 10, merchant_id: merchant.id)

      get "/api/v1/items/find_all?description=#{item.description}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info.count).to eq(11)
    end

    it "sends first instance by merchant_id" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      items = create_list(:item, 10, merchant_id: merchant.id)

      get "/api/v1/items/find?merchant_id=#{item.merchant_id}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info["attributes"]["id"]).to eq(item.id)
    end

    it "sends all instances by merchant_id" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      items = create_list(:item, 10, merchant_id: merchant.id)

      get "/api/v1/items/find_all?merchant_id=#{item.merchant_id}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info.count).to eq(11)
    end

    xit "sends first instance by unit_price" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id, unit_price: 2.25)
      items = create_list(:item, 10, merchant_id: merchant.id, unit_price: 2.25)

      get "/api/v1/items/find?unit_price=#{item.unit_price}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info["attributes"]["id"]).to eq(item.id)
    end

    xit "sends all instances by unit_price" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id, unit_price: 2.25)
      items = create_list(:item, 10, merchant_id: merchant.id, unit_price: 2.25)

      get "/api/v1/items/find_all?unit_price=#{item.unit_price}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info.count).to eq(11)
    end

    it "sends first instance by created_at" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id, created_at: "2020-02-02 00:35:22 UTC")
      items = create_list(:item, 10, merchant_id: merchant.id, created_at: "2020-02-02 00:35:22 UTC")

      get "/api/v1/items/find?created_at=#{item.created_at}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info["attributes"]["id"]).to eq(item.id)
    end

    it "sends all instances by created_at" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id, created_at: "2020-02-02 00:35:22 UTC")
      items = create_list(:item, 10, merchant_id: merchant.id, created_at: "2020-02-02 00:35:22 UTC")

      get "/api/v1/items/find_all?created_at=#{item.created_at}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info.count).to eq(11)
    end

    it "sends first instance by updated_at" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id, updated_at: "2020-02-02 00:35:22 UTC")
      items = create_list(:item, 10, merchant_id: merchant.id, updated_at: "2020-02-02 00:35:22 UTC")

      get "/api/v1/items/find?updated_at=#{item.updated_at}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info["attributes"]["id"]).to eq(item.id)
    end

    it "sends all instances by updated_at" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id, updated_at: "2020-02-02 00:35:22 UTC")
      items = create_list(:item, 10, merchant_id: merchant.id, updated_at: "2020-02-02 00:35:22 UTC")

      get "/api/v1/items/find_all?updated_at=#{item.updated_at}"
      expect(response).to be_successful

      item_info = JSON.parse(response.body)["data"]
      expect(item_info.count).to eq(11)
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
