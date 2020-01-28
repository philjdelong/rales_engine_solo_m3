namespace :import do
  task customers: :environment do
    Customer.destroy_all
    customers = CSV.foreach("./data/customers.csv", headers: true) do |row|
      if customer.save
        customer = Customer.create(first_name: row["first_name"], last_name: row["last_name"])
      end
    end
    customers
  end
end
