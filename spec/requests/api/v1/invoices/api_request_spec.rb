require 'rails_helper'

RSpec.describe "Invoices API" do
  it "sends a list of all invoice" do
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
