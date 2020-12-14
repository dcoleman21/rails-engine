require 'rails_helper'

describe "Merchant Search Endpoints" do
  it "can find a merchant that contain a fragment, case insensitive" do
    create(:merchant, name: "Thompson")
    create(:merchant, name: "Johnson")
    create(:merchant, name: "Son")
    create(:merchant, name: "Thatcher")

    get '/api/v1/merchants/find?name=SON'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a(Hash)

    merch_name = json[:data]

    expect(merch_name).to be_a(Hash)

    expect(merch_name).to have_key(:id)
    expect(merch_name[:id]).to be_a(String)

    expect(merch_name).to have_key(:type)
    expect(merch_name[:type]).to eq("merchant")

    expect(merch_name).to have_key(:attributes)
    expect(merch_name[:attributes]).to be_a(Hash)

    merchant_attr = merch_name[:attributes]

    expect(merchant_attr).to have_key(:name)
    expect(merchant_attr[:name]).to eq("Thompson")
  end

  it "can find all merchants that contain a fragment, case insensitive" do
    create(:merchant, name: "Thompson")
    create(:merchant, name: "Johnson")
    create(:merchant, name: "Son")
    create(:merchant, name: "Thatcher")

    get '/api/v1/merchants/find_all?name=SON'

    expect(response).to be_successful

    merch_with_son = JSON.parse(response.body, symbolize_names: true)

    expect(merch_with_son).to be_a(Hash)

    results = merch_with_son[:data]

    expect(results).to be_an(Array)
    expect(results.count).to eq(3)
  end
end
