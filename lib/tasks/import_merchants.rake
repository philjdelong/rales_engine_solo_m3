namespace :import do
  # describe "Import merchants from CSV"
  task merchants: :environment do
    merchants = []

    CSV.foreach("./data/merchants.csv", headers: true) do |row|
      merchant = Merchant.create(name: row["name"])
      merchants << merchant if merchant.save
    end
    merchants
  end
end
