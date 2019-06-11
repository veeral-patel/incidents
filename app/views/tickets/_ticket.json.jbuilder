json.extract! ticket, :id, :name, :incident_id, :created_at, :updated_at, :parent_id
json.url ticket_url(ticket, format: :json)
