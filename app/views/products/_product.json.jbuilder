json.extract! product, :id, :sku, :batch_size, :unit_type,  :created_at, :updated_at
json.url product_url(product, format: :json)
