require 'active_support/concern'
require 'reviewer/status'

module Reviewer
  module Reviewable
    extend ActiveSupport::Concern
    include Reviewer::Status

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

      # def status
      #   return :draft     if draft?
      #   return :rejected  if rejected?
      #   return :pending   if pending?
      #   return :reviewed  if reviewed?
      # end

      # def status?(query)
      #   send("#{query}?")
      # end

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
        [:draft, :rejected, :reviewed, :pending]
      end

      def draft
        # all.select { |i| i.draft? }
        query(:draft)
      end

      def rejected
        # all.select { |i| i.rejected? }
        query(:rejected)
      end

      def pending
        # all.select { |i| i.pending? }
        query(:pending)
      end

      def reviewed
        # all.select { |i| i.reviewed? }
        query(:reviewed)
      end

      def query(status)
        all.select { |i| i.send("#{status}?")}
      end
    end

  end
end
