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

    it "sends first instance by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find?id=#{invoice_item.id}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
    end

    it "sends first instance by quantity" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
    end

    it "sends first instance by item_id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
    end

    it "sends first instance by invoice_id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
    end

    xit "sends first instance by unit_price" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find?unit_price=#{invoice_item.unit_price}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
    end

    xit "sends first instance by created_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
    end

    xit "sends first instance by updated_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find?updated_at=#{invoice_item.updated_at}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
    end

    it "sends all instances by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find_all?id=#{invoice_item.id}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(1)
    end

    it "sends all instances by quantity" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find_all?quantity=#{invoice_item.quantity}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(11)
    end

    it "sends all instances by item_id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find_all?item_id=#{invoice_item.item_id}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(11)
    end

    it "sends all instances by invoice_id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item.invoice_id}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(11)
    end

    xit "sends all instances by unit_price" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item.unit_price}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(11)
    end

    xit "sends all instances by created_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find_all?created_at=#{invoice_item.created_at}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(11)
    end

    xit "sends all instances by updated_at" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/find_all?updated_at=#{invoice_item.updated_at}"
      expect(response).to be_successful

      invoice_item_info = JSON.parse(response.body)["data"]
      expect(invoice_item_info.count).to eq(11)
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
