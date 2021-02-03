lock "~> 3.15.0"

set :application, "connect_genkihirano"
set :repo_url, "git@github.com:GenkiHirano/connect.git"
set :rbenv_ruby, File.read('.ruby-version').strip

set :nginx_config_name, "#{fetch(:application)}.conf"
set :nginx_sites_enabled_path, "/etc/nginx/conf.d"

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "node_modules"

