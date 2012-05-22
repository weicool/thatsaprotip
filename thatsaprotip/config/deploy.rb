require "bundler/capistrano"

set :application, 'thatsaprotip'

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
ssh_options[:forward_agent] = true
set :repository,  'git@github.com:weicool/thatsaprotip.git'
set :scm, :git
set :deploy_to, '/home/weicool/thatsaprotip/public'
set :environment, 'production'
set :branch, 'master'
set :deploy_via, :remote_cache

server 'thatsaprotip.com', :app, :web, :db, :primary => true
set :user, 'weicool'
set :use_sudo, false

after 'deploy:setup', 'deploy:create_release_dir'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :create_release_dir, :except => {:no_release => true} do
    run "mkdir -p #{fetch :releases_path}"
  end
end
