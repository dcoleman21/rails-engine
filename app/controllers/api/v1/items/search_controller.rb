class Api::V1::Items::SearchController < ApplicationController
  def show
    item = Item.find_by("name ilike ?", "%#{params[:name]}%")
    render json: ItemSerializer.new(item)
  end

  def index
    items = Item.where("name ilike ?", "%#{params[:name]}%")
    render json: ItemSerializer.new(items)
  end
end
