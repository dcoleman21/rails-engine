require 'rails_helper'

describe "Item Search Endpoints" do
  it "can find a single item that contain a fragment, case insensitive" do
    create(:item, name: "Color ink")
    create(:item, name: "Pink Shoes")
    create(:item, name: "Chain link")
    create(:item, name: "Basketball")

    get '/api/v1/items/find?name=INK'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a(Hash)

    item_name = json[:data]

    expect(item_name).to be_a(Hash)

    expect(item_name).to have_key(:id)
    expect(item_name[:id]).to be_a(String)

    expect(item_name).to have_key(:type)
    expect(item_name[:type]).to eq("item")

    expect(item_name).to have_key(:attributes)
    expect(item_name[:attributes]).to be_a(Hash)

    item_attr = item_name[:attributes]

    expect(item_attr).to have_key(:name)
    expect(item_attr[:name]).to eq("Color ink")
  end

  it "can find all items that contain a fragment, case insensitive" do
    create(:item, name: "Color ink")
    create(:item, name: "Pink Shoes")
    create(:item, name: "Chain link")
    create(:item, name: "Basketball")

    get '/api/v1/items/find_all?name=INK'

    expect(response).to be_successful

    item_with_ink = JSON.parse(response.body, symbolize_names: true)
    
    expect(item_with_ink).to be_a(Hash)

    results = item_with_ink[:data]

    expect(results).to be_an(Array)
    expect(results.count).to eq(3)
  end
end
