namespace :import do
  task invoice_items: :environment do
    InvoiceItem.destroy_all
    invoice_items = CSV.foreach("./data/invoice_items.csv", headers: true) do |row|
      if invoice_item.save
        invoice_item = InvoiceItem.create(quantity: row["quantity"], unit_price: row["unit_price"], item_id: row["item_id"], invoice_id: row["invoice_id"])
      end
    end
    invoice_items
  end
end
