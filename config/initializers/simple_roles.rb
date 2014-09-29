SimpleRoles.configure do
  valid_roles :admin, :user
  strategy :one
end