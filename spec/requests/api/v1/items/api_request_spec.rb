require 'rails_helper'

RSpec.describe "Items API" do
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
end
