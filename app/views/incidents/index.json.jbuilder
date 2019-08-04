json.array! @incidents do |incident|
    json.id incident.id
    json.name incident.name
    json.created_at incident.created_at
    json.created_by incident.user.username
    json.status incident.status
    json.priority incident.priority
    json.assigned_to incident.assigned_to.username
    json.tags incident.tag_list
    json.description incident.description
end
