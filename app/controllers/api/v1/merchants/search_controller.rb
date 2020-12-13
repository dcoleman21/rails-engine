class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchants = Merchant.where("name ilike ?", "%#{params[:name]}%").limit(1).first
    render json: MerchantSerializer.new(merchants)
  end
end
