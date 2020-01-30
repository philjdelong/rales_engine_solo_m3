class Api::V1::Customers::FindController < ApplicationController

  def show
    param = request.query_parameters.values[0]
    customer = Customer.find(param)
    render json: CustomerSerializer.new(customer)
  end
end
