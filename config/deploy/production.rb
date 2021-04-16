server "13.114.155.139", user: "GenkiHirano", roles: %w(app db web)

set :ssh_options, {
  keys: %w(~/.ssh/connect_genkihirano2.pem),
  forward_agent: true,
  auth_methods: %w(publickey),
}
