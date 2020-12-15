class RevenueFacade
  def self.rev_by_dates(params)
    Invoice.joins(:transactions, :invoice_items)
      .select("sum(invoice_items.quantity * invoice_items.unit_price) as total")
      .where("invoices.status='shipped' AND transactions.result='success' AND invoices.created_at between '#{params['start']} 00:00:00' and '#{params['end']} 23:59:59'")[0]
  end
end
