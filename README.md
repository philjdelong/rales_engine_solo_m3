# README

**Deployed on Heroku**
_https://rales-engine-pd.herokuapp.com/api/v1_

**Endpoints**
- If importing, execute in the following order
_/merchants_
_/items_
_/customers_
_/invoices_
_/invoice_items_
_/transactions_

**Relationship Endpoints**
- Standard CRUD functionality used for all classes and paths
- Relationships set up to follow standard convention { :index, :show }
- Examples:
_/merchant/customers_
_/customer/invoices_
_/item/merchant_id_

**Business Logic Endpoints**
_/merchant/favorite_customer
_/customer/favorite_merchant

**Ruby version**
 _RUBY VERSION
    ruby 2.6.3p62

 BUNDLED WITH
    2.1.4_

**System dependencies**
 _bootsnap (>= 1.1.0)
 byebug
 coffee-rails (~> 4.2)
 factory_bot_rails
 faraday
 fast_jsonapi
 jbuilder (~> 2.5)
 listen (>= 3.0.5, < 3.2)
 pg (>= 0.18, < 2.0)
 pry
 puma (~> 3.11)
 rails (~> 5.2.4, >= 5.2.4.1)
 rake
 rspec-rails
 sass-rails (~> 5.0)
 spring
 spring-watcher-listen (~> 2.0.0)
 turbolinks (~> 5)
 tzinfo-data
 uglifier (>= 1.3.0)
 web-console (>= 3.3.0)

**Database creation and initialization**
 - _rails db:{ :create, :migrate, :seed }_

**Importing CSV data**
 - _rake import:{ :customers, :invoice_items, :invoices, :items, :merchants, :transactions }_

**How to run the test suite**
 - _bundle exec rspec_

**Additional Info**
 - _API follows standard JSON formatting using Serializers_
