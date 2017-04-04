require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class ReviewerGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def create_migration_file
        migration_template 'migration.rb', 'db/migrate/create_reviews.rb'
      end

    end
  end
end
