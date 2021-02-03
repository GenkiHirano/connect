server "54.168.46.152", user: "GenkiHirano", roles: %w(app db web)

set :ssh_options, {
  keys: %w(~/.ssh/connect_genkihirano.pem),
  forward_agent: true,
  auth_methods: %w(publickey),
}
