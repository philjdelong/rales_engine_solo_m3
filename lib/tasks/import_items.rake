namespace :import do
  task items: :environment do
    items = []

    CSV.foreach("./data/items.csv", headers: true) do |row|
      item = Item.create(name: row["name"], description: row["description"], merchant_id: row["merchant_id"])
      items << item if item.save
    end
    items
  end
end
