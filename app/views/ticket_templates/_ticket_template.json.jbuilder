json.extract! ticket_template, :id, :name, :description, :created_at, :updated_at
json.url ticket_template_url(ticket_template, format: :json)
