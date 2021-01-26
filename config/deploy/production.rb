set :ssh_options, {
  port: 22,
  keys: [File.expand_path('~/.ssh/connect-genkihirano_aws_rsa')],
  forward_agent: true,
  auth_methods: %w(publickey)
}