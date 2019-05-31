json.extract! ticket, :id, :name, :incident_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
