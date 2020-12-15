class MerchantFacade
  def self.most_revenue(quantity)
    Merchant.joins(invoices: [:transactions, :invoice_items])
     .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as most_revenue")
     .where("invoices.status='shipped' AND transactions.result='success'")
     .group("merchants.id")
     .order("most_revenue DESC")
     .limit(quantity)
  end

  def self.most_sold_items(quantity)
    Merchant.joins(invoices: [:transactions, :invoice_items])
     .select("merchants.*, sum(invoice_items.quantity) as most_sold_items")
     .where("invoices.status='shipped' AND transactions.result='success'")
     .group("merchants.id")
     .order("most_sold_items DESC")
     .limit(quantity)
  end
end
