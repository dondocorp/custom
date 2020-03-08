json.extract! input, :id, :product, :quantity, :delivery_date, :created_at, :updated_at
json.url input_url(input, format: :json)
