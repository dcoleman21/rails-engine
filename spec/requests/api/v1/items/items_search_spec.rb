require 'rails_helper'

describe "Item Search Endpoints" do
  it "can find a single item that contain a fragment, case insensitive" do
    create(:item, name: "")
  end
end
