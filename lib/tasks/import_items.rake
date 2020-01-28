namespace :import do
  task items: :environment do
    Item.destroy_all
    items = CSV.foreach("./data/items.csv", headers: true) do |row|
      if item.save
        item = Item.create(name: row["name"], description: row["description"], merchant_id: row["merchant_id"])
      end
    end
    items
  end
end
