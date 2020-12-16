class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.single_merchant(params[:name]))
  end

  def index
    render json: MerchantSerializer.new(Merchant.multiple_merchants(params[:name]))
  end
end
