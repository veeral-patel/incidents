json.set! :data do
  json.array! @users do |user|
    json.partial! 'users/user', user: user
    json.url  "
              #{link_to 'Show', user }
              #{link_to 'Edit', edit_user_path(user)}
              #{link_to 'Destroy', user, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end