require 'rails_helper'

describe "Merchant Items API" do
  it "returns all items associated with a merchant" do
    merchant_1 = create(:merchant, :with_items, items: 3).id
    # merchant_2 = create(:merchant, :with_items, items: 5)

    get "/api/v1/merchants/#{merchant_1}/items"

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]

    expect(items).to be_an(Array)
    expect(items.count).to eq(3)
  end
end
