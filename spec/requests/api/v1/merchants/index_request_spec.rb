require 'rails_helper'

RSpec.describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/merchants"

    expect(response).to be_successful
  end

  xit "sends a single merchant" do

  end
end
