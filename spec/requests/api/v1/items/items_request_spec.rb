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

  it "can create a new item" do
    merchant = create(:merchant)
    item_attr = {
      name: "Hydro Flask",
      description: "32oz water stainless steel water bottle",
      unit_price: 75.0,
      merchant_id: merchant.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v1/items', headers: headers, params: JSON.generate(item_attr)

    new_item = Item.last

    expect(response).to be_successful
    expect(new_item.name).to eq(item_attr[:name])
    expect(new_item.description).to eq(item_attr[:description])
    expect(new_item.unit_price).to eq(item_attr[:unit_price])
    expect(new_item.merchant_id).to eq(item_attr[:merchant_id])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Limited Addition Hydro Flask" }
    headers = {"CONTENT_TYPE" => "application/json"}
  end
end
