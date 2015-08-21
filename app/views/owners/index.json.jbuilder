json.array!(@owners) do |owner|
  json.extract! owner, :id, :first_name, :last_name, :phone, :email
  json.url owner_url(owner, format: :json)
end
