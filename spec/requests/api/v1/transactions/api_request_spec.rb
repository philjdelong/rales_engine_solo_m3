require 'rails_helper'

RSpec.describe "Transactions API" do
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
