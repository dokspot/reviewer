module Rails
  class << self
    def application
      :application
    end
  end
end

require 'reviewer'
require 'logger'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :reviews do |t|
    t.integer     :user_id
    t.integer     :item_id
    t.timestamp   :accepted_at
    t.timestamp   :rejected_at
    t.timestamp   :cancelled_at
    t.timestamps  null: false
  end

  create_table :papers do |t|
    t.string      :name
    t.timestamps  null: false
  end

  create_table :users do |t|
    t.integer     :paper_id
    t.timestamps  null: false
  end
end

class Review < ActiveRecord::Base
  review!
end

class Paper < ActiveRecord::Base
  reviewable!
  has_many :users

  def reviewers
    users
  end
end

class User < ActiveRecord::Base
  belongs_to :paper
end

# Cucumber::Rails::Database.autorun_database_cleaner = true
