require 'rails_helper'

describe Merchant do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'methods' do
    before :each do
      @m1 = create(:merchant, name: "Thompson, Inc.")
      @m2 = create(:merchant, name: "Johnson")
      @m3 = create(:merchant, name: "Son")
      @m4 = create(:merchant, name: "Thatcher")
      @m5 = create(:merchant, name: "Hollister")
      @m6 = create(:merchant, name: "Five Below")
      @m7 = create(:merchant, name: "Forager")

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

    describe 'class methods' do
      it 'can get a merchant that contains a fragment' do
        expect(Merchant.single_merchant('Son')).to eq(@m1)
      end

      it "can get all merchants that contain a fragment" do
        expect(Merchant.multiple_merchants('Son')).to eq([@m1, @m2, @m3])
      end

      it "returns top merchants in desc order by most revenue and limits by quantity given" do
        expect(Merchant.most_revenue(6)).to eq([@m6, @m5, @m4, @m3, @m2, @m1])
      end

      it "returns top merchants in desc order by items sold and limits by quantity given" do
        expect(Merchant.most_sold_items(6)).to eq([@m6, @m5, @m4, @m3, @m2, @m1])
      end

      xit "returns a single merchants total revenue" do
        expect(Merchant.total_revenue("#{@m4.id}")).to eq(280)
      end
    end
  end
end
