require 'rails_helper'

describe "Business Intelligence Endpoints" do
  describe "Revenue based on successful transaction and shipped to the customer " do
    before :each do
      @m1, @m2, @m3, @m4, @m5, @m6, @m7 = create_list(:merchant, 7)

      # one item per merchant
      @it1 = create(:item, merchant: @m1) # "Kerluke, Stiedemann and Hilper", id: 458
      @it2 = create(:item, merchant: @m2) # "Strosin, Heidenreich and Kulas", id: 459
      @it3 = create(:item, merchant: @m3) # "Fahey-Jaskolski", id: 460
      @it4 = create(:item, merchant: @m4) # "Abshire-Macejkovic" id: 461
      @it5 = create(:item, merchant: @m5) # "Monahan, Legros and Kirlin", id: 462
      @it6 = create(:item, merchant: @m6) # "Mueller, Mante and O'Keefe", id: 463
      @it7 = create(:item, merchant: @m7) # "Tillman, Stiedemann and Okuneva", id: 464

      # one invoice for each merchant, status=shipped, also set the created_at
      @iv1 = create(:invoice, merchant: @m1, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
      @iv2 = create(:invoice, merchant: @m2, status: 'shipped', created_at: '2020-02-02T00:00:00 UTC')
      @iv3 = create(:invoice, merchant: @m3, status: 'shipped', created_at: '2020-03-03T00:00:00 UTC')
      @iv4 = create(:invoice, merchant: @m4, status: 'shipped', created_at: '2020-04-04T00:00:00 UTC')
      @iv5 = create(:invoice, merchant: @m5, status: 'shipped', created_at: '2020-05-05T00:00:00 UTC')
      @iv6 = create(:invoice, merchant: @m6, status: 'shipped', created_at: '2020-05-05T00:00:00 UTC')
      @iv7 = create(:invoice, merchant: @m7, status: 'packaged', created_at: '2020-05-05T00:00:00 UTC')

      # one invoice_item for each invoice, low quantity and price to high quantity and price
      @ii1 = create(:invoice_item, invoice: @iv1, item: @it1, quantity: 10, unit_price: 1) # rev: $10
      @ii2 = create(:invoice_item, invoice: @iv2, item: @it2, quantity: 20, unit_price: 3) # rev: $60
      @ii3 = create(:invoice_item, invoice: @iv3, item: @it3, quantity: 30, unit_price: 5) # rev: $150
      @ii4 = create(:invoice_item, invoice: @iv4, item: @it4, quantity: 40, unit_price: 7) # rev: $280
      @ii5 = create(:invoice_item, invoice: @iv5, item: @it5, quantity: 50, unit_price: 9) # rev: $450
      @ii6 = create(:invoice_item, invoice: @iv6, item: @it6, quantity: 60, unit_price: 11) # rev: $660
      @ii7 = create(:invoice_item, invoice: @iv7, item: @it7, quantity: 70, unit_price: 13) # rev: $910

      # one transaction for each invoice which are result=success
      @t1 = create(:transaction, invoice: @iv1, result: 'success')
      @t2 = create(:transaction, invoice: @iv2, result: 'success')
      @t3 = create(:transaction, invoice: @iv3, result: 'success')
      @t4 = create(:transaction, invoice: @iv4, result: 'success')
      @t5 = create(:transaction, invoice: @iv5, result: 'success')
      @t6 = create(:transaction, invoice: @iv6, result: 'success')
      @t7 = create(:transaction, invoice: @iv7, result: 'success')
    end
    it "can get merchants with most revenue" do
      get '/api/v1/merchants/most_revenue?quantity=7'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      merchants = json[:data]

      expect(merchants).to be_an(Array)
      expect(merchants.length).to eq(6)

      expect(merchants[0]).to have_key(:id)
      expect(merchants[0][:id]).to be_a(String)

      expect(merchants[0]).to have_key(:type)
      expect(merchants[0][:type]).to eq("merchant")

      expect(merchants[0]).to have_key(:attributes)
      expect(merchants[0][:attributes]).to be_a(Hash)

      expect(merchants[0][:attributes]).to have_key(:name)
      expect(merchants[0][:attributes][:name]).to be_a(String)

      expect(merchants[0][:attributes][:name]).to eq(@m6.name)
      expect(merchants[1][:attributes][:name]).to eq(@m5.name)
      expect(merchants[2][:attributes][:name]).to eq(@m4.name)
      expect(merchants[3][:attributes][:name]).to eq(@m3.name)
      expect(merchants[4][:attributes][:name]).to eq(@m2.name)
      expect(merchants[5][:attributes][:name]).to eq(@m1.name)
    end

    it "can get merchants with most items sold" do
      get '/api/v1/merchants/most_items?quantity=6'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      merchants = json[:data]

      expect(merchants).to be_an(Array)
      expect(merchants.length).to eq(6)

      expect(merchants[0]).to have_key(:id)
      expect(merchants[0][:id]).to be_a(String)

      expect(merchants[0]).to have_key(:attributes)
      expect(merchants[0]).to be_a(Hash)

      expect(merchants[0][:attributes]).to have_key(:name)
      expect(merchants[0][:attributes][:name]).to be_a(String)

      expect(merchants[0][:attributes][:name]).to eq(@m6.name)
      expect(merchants[1][:attributes][:name]).to eq(@m5.name)
      expect(merchants[2][:attributes][:name]).to eq(@m4.name)
      expect(merchants[3][:attributes][:name]).to eq(@m3.name)
      expect(merchants[4][:attributes][:name]).to eq(@m2.name)
      expect(merchants[5][:attributes][:name]).to eq(@m1.name)
    end

    it "can get total revenue across all merchants between given dates" do
      get '/api/v1/revenue?start=2020-03-03&end=2020-05-05'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)
      rev_by_dates = json[:data]

      expect(rev_by_dates).to be_a(Hash)

      expect(rev_by_dates).to have_key(:type)
      expect(rev_by_dates[:type]).to eq("revenue")

      expect(rev_by_dates).to have_key(:attributes)
      expect(rev_by_dates[:attributes]).to be_a(Hash)

      total_rev = rev_by_dates[:attributes]

      expect(total_rev).to have_key(:revenue)
      expect(total_rev[:revenue]).to be_a(Float)
      expect(total_rev[:revenue]).to eq(1540.0)
    end

    it "can get total revenue for a single merchant" do
      get "/api/v1/merchants/#{@m2.id}/revenue"

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)
      merch_rev = json[:data]

      expect(merch_rev).to be_a(Hash)
      expect(merch_rev).to have_key(:attributes)
      expect(merch_rev[:attributes]).to be_a(Hash)

      total_rev = merch_rev[:attributes]

      expect(total_rev).to have_key(:revenue)
      expect(total_rev[:revenue]).to be_a(Float)
      expect(total_rev[:revenue]).to eq(60.0)
    end
  end
end
