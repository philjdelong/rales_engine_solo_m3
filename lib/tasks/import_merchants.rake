namespace :import do
  task merchants: :environment do
    Merchant.destroy_all
    merchants = CSV.foreach("./data/merchants.csv", headers: true) do |row|
      merchant = Merchant.create(name: row["name"])
    end
    merchants
  end
end
