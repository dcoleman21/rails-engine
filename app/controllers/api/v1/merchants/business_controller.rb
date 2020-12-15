class Api::V1::Merchants::BusinessController < ApplicationController
  def most_revenue
    merchants = MerchantFacade.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end
