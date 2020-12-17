require 'rails_helper'

describe Item do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'class methods' do
    describe  'single_search(name)' do
      it "can get a single item that contains a fragment" do
        it1 = create(:item, name: "Color ink")
        it2 = create(:item, name: "Pink Shoes")
        it3 = create(:item, name: "Chain link")
        it4 = create(:item, name: "Basketball")

        expect(Item.single_item('INK')).to eq(it1)
      end
    end

    describe  'multiple_search(name)' do
      it "can get all items that contain a fragment" do
        it1 = create(:item, name: "Color ink")
        it2 = create(:item, name: "Pink Shoes")
        it3 = create(:item, name: "Chain link")
        it4 = create(:item, name: "Basketball")

        expect(Item.multiple_items('INK')).to eq([it1, it2, it3])
      end
    end
  end
end
