class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :revenue do |object|
    object.total.to_f.round(2)
  end
end
