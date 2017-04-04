require 'active_support/concern'

module Reviewer
  module Reviewable
    extend ActiveSupport::Concern

    included do
      has_many :reviews, as: :item

      def draft?
        # No reviews
        reviews.empty?
      end

      def rejected?
        # Min. 1 rejected review
        !draft? && reviews.pluck(:rejected_at).any?
      end

      def reviewed?
        # All reviews accepted
        !draft? && reviews.pluck(:accepted_at).all?
      end

      def pending_review?
        # Not any of the above
        !draft? && !reviewed? && !rejected?
      end

      def status
        return :draft           if draft?
        return :rejected        if rejected?
        return :pending_review  if pending_review?
        return :reviewed        if reviewed?
      end

      def status?(query)
        send("#{query}?")
      end

      def review!
        transaction do
          reviewers.each { |r| reviews.create(user: r) }
        end
      rescue => e
        puts e.message
      end

      def cancel!
        puts "Reviewable.cancel!"
        transaction do
          reviews.where(cancelled_at: nil).each { |r| r.update(cancelled_at: Time.now) }
        end
      rescue => e
        puts e.message
      end

    end

    class_methods do
      def draft
        Object.const_get(name).all.select { |i| i.draft? }
      end

      def rejected
        Object.const_get(name).all.select { |i| i.rejected? }
      end

      def pending_review
        Object.const_get(name).all.select { |i| i.pending_review? }
      end

      def reviewed
        Object.const_get(name).all.select { |i| i.reviewed? }
      end
    end

  end
end
