require 'rails_helper'

describe "Items API" do
  it "sends a list of all items" do
    create_list(:item, 4)

    get '/api/v1/items'
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]

    expect(items.count).to eq(4)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      item_data = item[:attributes]

      expect(item_data).to have_key(:name)
      expect(item_data[:name]).to be_a(String)

      expect(item_data).to have_key(:description)
      expect(item_data[:description]).to be_a(String)

      expect(item_data).to have_key(:unit_price)
      expect(item_data[:unit_price]).to be_a(Float)

      expect(item_data).to have_key(:merchant_id)
      expect(item_data[:merchant_id]).to be_an(Integer)
    end
  end

  it "can get a single item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    json = JSON.parse(response.body, symbolize_names: true)
    item = json[:data]

    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)

    expect(item).to have_key(:type)
    expect(item[:type]).to eq("item")

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)

    item_data = item[:attributes]

    expect(item_data).to have_key(:name)
    expect(item_data[:name]).to be_a(String)

    expect(item_data).to have_key(:description)
    expect(item_data[:description]).to be_a(String)

    expect(item_data).to have_key(:unit_price)
    expect(item_data[:unit_price]).to be_a(Float)

    expect(item_data).to have_key(:merchant_id)
    expect(item_data[:merchant_id]).to be_an(Integer)
  end
end
