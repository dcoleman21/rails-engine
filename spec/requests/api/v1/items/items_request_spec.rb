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

      item_attr = item[:attributes]

      expect(item_attr).to have_key(:name)
      expect(item_attr[:name]).to be_a(String)

      expect(item_attr).to have_key(:description)
      expect(item_attr[:description]).to be_a(String)

      expect(item_attr).to have_key(:unit_price)
      expect(item_attr[:unit_price]).to be_a(Float)

      expect(item_attr).to have_key(:merchant_id)
      expect(item_attr[:merchant_id]).to be_an(Integer)
    end
  end

  it "can get a single item by its id" do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

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
    item_attr = { name: "Limited Addition Hydro Flask" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_attr)
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Limited Addition Hydro Flask")
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)
    expect { delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(response.status).to eq(204)
  end

  it "cannot destroy an item without an id" do
    item = create(:item, id: 4)

    delete "/api/v1/items/2"

    expect(response.status).to_not eq(200)
    expect(response.status).to eq(204)
  end
end
