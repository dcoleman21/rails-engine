class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.most_revenue(quantity)
    joins(invoices: [:transactions, :invoice_items])
     .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as most_revenue")
     .where("invoices.status='shipped' AND transactions.result='success'")
     .group("merchants.id")
     .order("most_revenue DESC")
     .limit(quantity)
  end

  def self.most_sold_items(quantity)
    joins(invoices: [:transactions, :invoice_items])
     .select("merchants.*, sum(invoice_items.quantity) as most_sold_items")
     .where("invoices.status='shipped' AND transactions.result='success'")
     .group("merchants.id")
     .order("most_sold_items DESC")
     .limit(quantity)
  end

  # def self.total_revenue(id)
  #   joins(invoices: [:invoice_items, :transactions])
  #     .where("invoices.status='shipped' AND transactions.result='success' AND #{id: id}")
  #     .sum("invoice_items.quantity * invoice_items.unit_price")
  # end
end
