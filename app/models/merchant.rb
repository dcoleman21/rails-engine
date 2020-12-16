class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.single_merchant(name)
    Merchant.find_by("name ilike ?", "%#{name}%")
  end

  def self.multiple_merchants(name)
    Merchant.where("name ilike ?", "%#{name}%")
  end

  def self.most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .merge(Invoice.unscoped.successful)
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.most_sold_items(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS quantity_of_items")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .merge(Invoice.unscoped.successful)
      .group(:id)
      .order('quantity_of_items DESC')
      .limit(quantity)
  end

  def self.total_revenue(_id)
    select("merchants.id")
      .joins(invoices: %i[invoice_items transactions])
      .merge(Invoice.successful)
      .merge(Transaction.successful)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end
  # Failure/Error: object.total
  #
  #    NoMethodError:
  #      undefined method `total' for 2520.0:Float
  #    # ./app/serializers/revenue_serializer.rb:5:in `block in <class:RevenueSerializer>'
  #    # ./app/controllers/api/v1/merchants/business_controller.rb:18:in `merchant_revenue'
  #    # ./spec/requests/api/v1/merchants/business_intel_spec.rb:126:in `block (3 levels) in <top (required)>'
end
