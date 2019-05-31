json.extract! incident, :id, :name, :created_at, :updated_at
json.url incident_url(incident, format: :json)
