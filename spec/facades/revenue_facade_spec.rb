require 'rails_helper'

describe "Revenue Facade" do
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
    @iv1 = create(:invoice, merchant: @m1, status: 'shipped')
    @iv2 = create(:invoice, merchant: @m2, status: 'shipped')
    @iv3 = create(:invoice, merchant: @m3, status: 'shipped')
    @iv4 = create(:invoice, merchant: @m4, status: 'shipped')
    @iv5 = create(:invoice, merchant: @m5, status: 'shipped')
    @iv6 = create(:invoice, merchant: @m6, status: 'shipped')
    @iv7 = create(:invoice, merchant: @m7, status: 'packaged')

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

  xit "returns revenue betweeen given dates" do
     revenue = RevenueFacade.rev_by_dates('dates')
     expect(revenue).to be_a(Revenue)
     expect(revenue.id).to eq(nil)
     expect(revenue.revenue).to be_a(Float)
  end
end
