class Api::V1::Merchants::BusinessController < ApplicationController
  def most_revenue
    merchants = Merchant.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def most_items
    merchants = Merchant.most_sold_items(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def rev_by_dates
    total_revenue = RevenueFacade.rev_by_dates(date_params)
    render json: RevenueSerializer.new(total_revenue)
  end

  def merchant_revenue
    render json: RevenueSerializer.new(Merchant.total_revenue(params[:id]))
  end

  private

  def date_params
    params.permit(:start, :end)
  end
end
