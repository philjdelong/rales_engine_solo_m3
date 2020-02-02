class Api::V1::Customers::FindController < ApplicationController

  def show
    customer = Customer.find_by(customer_info)
    render json: CustomerSerializer.new(customer)
  end

  def index
    customers = Customer.where(customer_info)
    render json: CustomerSerializer.new(customers)
  end

  private
    def customer_info
      params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
    end
end
