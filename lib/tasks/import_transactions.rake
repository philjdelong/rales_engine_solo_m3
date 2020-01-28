namespace :import do
  task transactions: :environment do
    transactions = []

    CSV.foreach("./data/transactions.csv", headers: true) do |row|
      transaction = Transaction.create(invoice_id: row["invoice_id"], credit_card_number: row["credit_card_number"], credit_card_expiration_date: row["credit_card_expiration_date"], result: row["result"])
      transactions << transaction if transaction.save
    end
    transactions
  end
end
