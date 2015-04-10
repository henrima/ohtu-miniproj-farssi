json.array!(@entries) do |entry|
  json.extract! entry, :id, :category
  json.url entry_url(entry, format: :json)
end
