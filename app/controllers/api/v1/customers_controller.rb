class Api::V1::CustomersController < ApplicationController

  def index
    merchants = Customer.all
    render json: CustomerSerializer.new(merchants)
  end

  def show
    merchant = Customer.find(params[:id])
    render json: CustomerSerializer.new(merchant)
  end
end
