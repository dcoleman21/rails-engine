class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.single_item(params[:name]))
  end

  def index
    render json: ItemSerializer.new(Item.multiple_items(params[:name]))
  end
end
