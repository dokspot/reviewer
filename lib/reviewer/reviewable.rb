require 'active_support/concern'
require 'reviewer/states'

module Reviewer
  module Reviewable
    extend ActiveSupport::Concern
    include Reviewer::States

    included do
      has_many :reviews, as: :item

      def draft?
        # No reviews
        reviews.empty? || reviews.pluck(:cancelled_at).all?
      end

      def rejected?
        # Min. 1 rejected review
        !draft? && reviews.pluck(:rejected_at).any?
      end

      def reviewed?
        # All reviews accepted
        !draft? && reviews.pluck(:accepted_at).all?
      end

      def pending?
        # Not any of the above
        !draft? && !reviewed? && !rejected?
      end

      def review!
        raise ArgumentError, status if !draft?
        transaction do
          reviewers.each { |r| reviews.create(user: r) }
        end
      rescue => e
        e
      end

      def cancel!
        raise ArgumentError, status if draft?
        transaction do
          reviews.each { |r| r.cancel! }
        end
      rescue => e
        e
      end

    end

    class_methods do
      def states
        super + [:draft, :rejected, :reviewed, :pending]
      end

      def draft
        query(:draft)
      end

      def rejected
        query(:rejected)
      end

      def pending
        query(:pending)
      end

      def reviewed
        query(:reviewed)
      end
    end

  end
end
