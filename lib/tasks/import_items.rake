namespace :import do
  task items: :environment do
    Item.destroy_all
    items = CSV.foreach("./data/items.csv", headers: true) do |row|
      item = Item.create(name: row["name"], description: row["description"], unit_price: row["unit_price"], merchant_id: row["merchant_id"])
    end
    items
  end
end
