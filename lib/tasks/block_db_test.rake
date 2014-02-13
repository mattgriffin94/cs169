namespace :db do 
  namespace :test do 
    task :reset do 
      ActiveRecord::Base.establish_connection('production')
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
      ActiveRecord::Base.establish_connection(ENV['RAILS_ENV'])  #Make sure you don't have side-effects!
    end
  end
end