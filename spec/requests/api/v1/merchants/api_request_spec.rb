require 'rails_helper'

RSpec.describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"
    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  it "sends a single merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(id)
  end
end
