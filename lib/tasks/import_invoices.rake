namespace :import do
  task invoices: :environment do
    Invoice.destroy_all
    invoices = CSV.foreach("./data/invoices.csv", headers: true) do |row|
      if invoice.save
        invoice = Invoice.create(customer_id: row["customer_id"], merchant_id: row["merchant_id"], status: row["status"])
      end
    end
    invoices
  end
end
