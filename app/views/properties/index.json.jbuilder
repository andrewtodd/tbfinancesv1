json.array!(@properties) do |property|
  json.extract! property, :id, :address_line1, :address_line2, :city, :country, :postal_code,
  json.url property_url(property, format: :json)
end
