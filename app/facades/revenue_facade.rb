class RevenueFacade
  def self.rev_by_dates(params)
    Invoice.joins(:transactions, :invoice_items)
      .select("sum(invoice_items.quantity * invoice_items.unit_price) as total")
      .merge(Transaction.unscoped.successful)
      .merge(Invoice.unscoped.successful)
      .where("invoices.created_at between '#{params['start']} 00:00:00' and '#{params['end']} 23:59:59'")[0]
  end
end
