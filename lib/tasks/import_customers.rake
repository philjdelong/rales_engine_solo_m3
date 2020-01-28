namespace :import do
  task customers: :environment do
    customers = []

    CSV.foreach("./data/customers.csv", headers: true) do |row|
      customer = Customer.create(first_name: row["first_name"], last_name: row["last_name"])
      customers << customer if customer.save
    end
    customers
  end
end
