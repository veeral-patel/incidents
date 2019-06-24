json.set! :data do
  json.array! @ticket_templates do |ticket_template|
    json.partial! 'ticket_templates/ticket_template', ticket_template: ticket_template
    json.url  "
              #{link_to 'Show', ticket_template }
              #{link_to 'Edit', edit_ticket_template_path(ticket_template)}
              #{link_to 'Destroy', ticket_template, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end