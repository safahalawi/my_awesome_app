json.extract! user, :id, :first_name, :last_name, :email, :created_at, :updated_at, :role
json.url user_url(user, format: :json)
