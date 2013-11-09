load 'deploy/assets'

set :application, 'thatsaprotip'

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
ssh_options[:forward_agent] = true
set :repository,  'git@github.com:weicool/thatsaprotip.git'
set :scm, :git
set :deploy_to, '/home/weicool/thatsaprotip/public/rails'
set :environment, 'production'
set :branch, 'master'

server 'thatsaprotip.com', :app, :web, :db, :primary => true
set :user, 'weicool'
set :use_sudo, false

set :deploy_subdir, 'thatsaprotip'

require 'capistrano/recipes/deploy/strategy/remote_cache'

class RemoteCacheSubdir < Capistrano::Deploy::Strategy::RemoteCache

  private

  def repository_cache_subdir
    if configuration[:deploy_subdir] then
      File.join(repository_cache, configuration[:deploy_subdir])
    else
      repository_cache
    end
  end

  def copy_repository_cache
    logger.trace "copying the cached version to #{configuration[:release_path]}"
    if copy_exclude.empty?
      run "cp -RPp #{repository_cache_subdir} #{configuration[:release_path]} && #{mark}"
    else
      exclusions = copy_exclude.map { |e| "--exclude=\"#{e}\"" }.join(' ')
      run "rsync -lrpt #{exclusions} #{repository_cache_subdir}/* #{configuration[:release_path]} && #{mark}"
    end
  end

end

set :strategy, RemoteCacheSubdir.new(self)

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
# end
