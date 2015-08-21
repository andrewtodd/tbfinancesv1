json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :generated_by, :amount, :transaction_type, :date, :tennant_id, :name, :category, :owner_id
  json.url transaction_url(transaction, format: :json)
end
