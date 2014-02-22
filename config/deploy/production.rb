role :app, "generator.raedatoui.com"
set :deploy_to, "/srv/www/generator.raedatoui.com/app/"
set :scm_command, '/usr/bin/git'
set :user, "deploy"
set :scm_passphrase, '3ntiss@r'
default_run_options[:pty] = true
