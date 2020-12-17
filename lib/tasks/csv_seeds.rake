require 'csv'

namespace :db do
  namespace :data do
    desc 'Seed csv data from db/data to database table'
    task seedCSV: :environment do
      Rake::Task['db:drop'].execute
      Rake::Task['db:create'].execute
      Rake::Task['db:migrate'].execute
      puts('Records destroyed')

      cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
      puts "Loading PostgreSQL Data dump into local database with command:"
      puts cmd
      system(cmd)

      CSV.foreach(Rails.root.join('db/data/items.csv'), headers: true) do |row|
        row["unit_price"] = (row["unit_price"].to_f / 100).round(2)
        Item.create(row.to_h)
      end
      
      ActiveRecord::Base.connection.tables.each do |t|
        ActiveRecord::Base.connection.reset_pk_sequence!(t)
      end
    end
  end
end
