namespace :import do
  task transactions: :environment do
    Transaction.destroy_all
    transactions = CSV.foreach("./data/transactions.csv", headers: true) do |row|
      if transaction.save
        transaction = Transaction.create(invoice_id: row["invoice_id"], credit_card_number: row["credit_card_number"], credit_card_expiration_date: row["credit_card_expiration_date"], result: row["result"])
      end
    end
    transactions
  end
end
