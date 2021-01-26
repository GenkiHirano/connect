server '18.179.117.162', user: 'GenkiHirano', roles: %w{app db web} 

set :ssh_options, keys: '~/.ssh/connect-genkihirano.pem' 