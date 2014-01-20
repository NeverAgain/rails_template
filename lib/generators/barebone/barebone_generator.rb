require 'securerandom'

class BareboneGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  @password = SecureRandom.base64 8

  def main
    gem_setup
    gemset_setup

    run "bundle install"

    database_setup

    cleanup
  end

  private

  def application_name
    if defined?(Rails) && Rails.application
      Rails.application.class.name.split('::').first.underscore
    else
      "application"
    end
  end

  def gem_setup
    gsub_file 'Gemfile', /gem 'sqlite3'\n/, "gem 'mysql2'\n"

    gem 'haml'

    gem_group :development do
      gem 'better_errors'
      gem 'binding_of_caller'
    end

    gem 'compass-rails'
  end

  def database_setup
    gsub_file 'config/database.yml',
      /database.*\n/,
      "database: mysql2\n  username: #{application_name}\n  password: #{@password}\n"
    gsub_file 'config/database.yml',
      /adapter.*\n/,
      "adapter: mysql2\n"
  end

  def gemset_setup
    run "rvm gemset create #{application_name}"
    run "rvm gemset use #{application_name}"

    create_file '.ruby-version', "2.1.0"
    create_file '.ruby-gemset', "#{application_name}"
  end

  def cleanup
    remove_file 'app/views/layouts/application.html.erb'

    copy_file 'application.html.haml', 'app/views/layouts/application.html.haml'
  end

end
