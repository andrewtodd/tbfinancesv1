json.array!(@tennants) do |tennant|
  json.extract! tennant, :id, :first_name, :last_name, :property_id, :email, :phone, :notes
  json.url tennant_url(tennant, format: :json)
end
