require 'rails_helper'

describe "Items Merchant API" do
  it "can return the merchant associated with an item" do
    create(:item)

    get "/api/v1/items/#{Item.last.id}/merchants"
    
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchant = json[:data]
    expect(merchant[:id]).to eq(Merchant.last.id.to_s)
  end
end
