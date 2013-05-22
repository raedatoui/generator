role :app, "generator.raedatoui.com"
set :deploy_to, "/srv/www/generator.raedatoui.com/app/"
set :scm_command, '/usr/bin/git'
set :user, "www-data"
set :scm_passphrase, 'entissar151'
default_run_options[:pty] = true
