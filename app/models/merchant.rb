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
      .group(:id).order('quantity_of_items DESC')
      .limit(quantity)
  end

  def self.total_revenue(id)
    select("merchants.id, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.unscoped.successful)
      .merge(Invoice.unscoped.successful)
      .where({invoices: {merchant_id: id} })
      .group("merchants.id").first
  end
end
