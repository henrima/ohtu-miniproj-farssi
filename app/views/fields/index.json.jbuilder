json.array!(@fields) do |field|
  json.extract! field, :id, :name, :content, :entry_id
  json.url field_url(field, format: :json)
end
