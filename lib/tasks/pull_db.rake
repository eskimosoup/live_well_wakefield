# https://martinschurig.com/posts/2015/02/pulling-production-database-to-local-machine-rails-task/
# frozen_string_literal: true
namespace :db do
  desc 'Pull production db to development'
  task pull: %i[dump restore:local site_settings remote_assets]

  dumpfile = 'db.dump'

  desc 'Dump remote postgres database'
  task :dump do
    production = Rails.application.config.database_configuration['production']
    export_dump_file_command = "su - postgres bash -c \"PGPASSFILE=~/.pgpassfile.conf pg_dump -U postgres #{production['database']} --host=localhost --format=tar --file=#{dumpfile}\""

    puts 'Running PG_DUMP on production'

    system "ssh root@my3.allofmy.co.uk -t '#{export_dump_file_command}'"
    system "scp root@my3.allofmy.co.uk:/var/lib/postgresql/#{dumpfile} #{Rails.root}"
    system "ssh root@my3.allofmy.co.uk -t 'rm -f /var/lib/postgresql/#{dumpfile}'"
  end

  namespace :restore do
    dev = Rails.application.config.database_configuration['development']
    pg_restore = "PGPASSWORD=#{dev['password']} pg_restore --verbose --clean --no-acl --no-owner -h localhost -d #{dev['database']} -U #{dev['username']}"

    desc 'Remote restore'
    task :remote do
      dump_file_path = "/tmp/#{dumpfile}"
      restore_command = "#{pg_restore} #{dump_file_path}"
      system "scp #{Rails.root}/#{dumpfile} root@aleut:#{dump_file_path}"
      system "ssh root@aleut -t '#{restore_command} && rm -f #{dump_file_path}'"
      File.delete(dumpfile)
    end

    desc 'Local restore'
    task :local do
      dump_file_path = dumpfile
      restore_command = "#{pg_restore} #{dump_file_path}"
      system restore_command
      File.delete(dumpfile)
    end
  end

  desc 'Set database environment and update any environment based settings'
  task :site_settings do
    system("rails runner \"Optimadmin::SiteSetting.where(environment: 'development').destroy_all\"")
    system("rails runner \"Optimadmin::SiteSetting.where(environment: 'production').update_all(environment: 'development')\"")
    system('RAILS_ENV=development bin/rails db:environment:set')
  end

  desc 'Pull remote assets if Capistrano is available'
  task :remote_assets do
    system "cap production uploads:download" if File.exist?(Rails.root.join('Capfile'))
  end
end
