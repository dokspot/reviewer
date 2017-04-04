require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module Reviewer
    class InstallGenerator < ::Rails::Generators::Base
        include ::Rails::Generators::Migration

        source_root File.expand_path('../templates', __FILE__)

        def create_migration_file
            migration_template 'migration.rb', 'db/migrate/create_reviews.rb'
        end

        def self.next_migration_number(dirname)
            ActiveRecord::Generators::Base.next_migration_number(dirname)
        end
    end
end
