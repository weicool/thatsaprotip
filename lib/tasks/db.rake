namespace :db do
  desc "drop create migrate"
  task :dcm do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
  end
end
