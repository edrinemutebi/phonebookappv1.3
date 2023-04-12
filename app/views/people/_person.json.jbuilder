json.extract! person, :id, :name, :phone, :email, :birthday, :created_at, :updated_at
json.url person_url(person, format: :json)
