require 'bundler/capistrano'
require 'delayed/recipes'

set :keep_releases, 11

set :use_sudo, false
set :application, "egg"

set :deploy_to, "/var/www/apps/#{application}"

set :scm, :git
set :repository, "git@github.com:ASCTech/egg.git"
set :branch, "master"
set :branch, $1 if `git branch` =~ /\* (\S+)\s/m
set :deploy_via, :remote_cache

set :user, 'deploy'

task :production do
  set :rails_env, "production"
  set :branch, 'master'
  role :app, "164.107.177.50"
  role :web, "164.107.177.50"
  role :db,  "164.107.177.50", :primary => true
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :seed, :roles => :app do
    run "cd #{current_path} && #{rake} RAILS_ENV=#{rails_env} db:seed"
  end
end

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true, :cowboy_deploy => true } do
      run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
    end
  end
end

before "deploy:assets:precompile" do
  run [
    "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml",
    "ln -fs #{shared_path}/tmp/pids #{release_path}/tmp/pids",
    "rm #{release_path}/public/system"
  ].join(" && ")
end

after 'deploy', 'delayed_job:restart', 'deploy:cleanup'
