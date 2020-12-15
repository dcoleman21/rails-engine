class Api::V1::Merchants::BusinessController < ApplicationController
  def most_revenue
    merchants = MerchantFacade.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def most_items
    merchants = MerchantFacade.most_sold_items(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def rev_by_dates
    total_revenue = RevenueFacade.rev_by_dates(date_params)
    render json: RevenueSerializer.new(total_revenue)
  end

  private

  def date_params
    params.permit(:start, :end)
  end
end
