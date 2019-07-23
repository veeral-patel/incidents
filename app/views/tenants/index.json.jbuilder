json.set! :data do
  json.array! @tenants do |tenant|
    json.partial! 'tenants/tenant', tenant: tenant
    json.url  "
              #{link_to 'Show', tenant }
              #{link_to 'Edit', edit_tenant_path(tenant)}
              #{link_to 'Destroy', tenant, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end