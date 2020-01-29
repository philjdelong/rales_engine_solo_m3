class InvoiceSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :customer
  belongs_to :merchant

  attributes :id, :customer_id, :merchant_id, :status 
end
