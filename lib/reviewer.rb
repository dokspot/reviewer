require 'reviewer/version'
require 'reviewer/review'
require 'reviewer/reviewable'
require 'active_record' unless defined?(ActiveRecord)

require 'active_support/concern'

module Reviewer
  extend ActiveSupport::Concern

  class_methods do
    def review!
      include Reviewer::Review
    end

    def reviewable!
      include Reviewer::Reviewable
    end
  end

end

ActiveRecord::Base.extend Reviewer::ClassMethods
