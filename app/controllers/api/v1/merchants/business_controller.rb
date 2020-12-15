class Api::V1::Merchants::BusinessController < ApplicationController
  def most_revenue
    merchants = MerchantFacade.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def most_items
    merchants = MerchantFacade.most_sold_items(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end
