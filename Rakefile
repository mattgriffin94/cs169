# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Mysite::Application.load_tasks

RSpec::Core::RakeTask.new(:test)

task :default => :test