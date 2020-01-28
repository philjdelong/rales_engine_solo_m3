namespace :import do
  task invoice_items: :environment do
    invoice_items = []

    CSV.foreach("./data/invoice_items.csv", headers: true) do |row|
      invoice_item = InvoiceItem.create(quantity: row["quantity"], unit_price: row["unit_price"], item_id: row["item_id"], invoice_id: row["invoice_id"])
      invoice_items << invoice_item if invoice_item.save
    end
    invoice_items
  end
end
