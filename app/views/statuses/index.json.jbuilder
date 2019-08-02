json.set! :data do
  json.array! @statuses do |status|
    json.partial! 'statuses/status', status: status
    json.url  "
              #{link_to 'Show', status }
              #{link_to 'Edit', edit_status_path(status)}
              #{link_to 'Destroy', status, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end