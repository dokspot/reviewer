require 'active_support/concern'

module Reviewer
  module Reviewable
    extend ActiveSupport::Concern

    included do
      has_many :reviews, as: :item

      def draft?
        reviews.empty?
      end

      def rejected?
        !reviews.empty? && reviews.rejected.any?
      end

      def pending_review?
        !reviewed? && !rejected?
      end

      def reviewed?
        reviews.any? && reviews.accepted.all?
      end

      def status
        return :draft           if draft?
        return :rejected        if accepted?
        return :pending_review  if pending_review?
        return :reviewed        if reviewed?
      end

      def status?(query)
        send("#{query}?")
      end

      def review!
        send(:before_review) if respond_to(:before_review)
        transaction do
          reviewers.each { |r| reviews.create(user: a) }
        end
      rescue => e
        e
      end

      def cancel!
        send(:before_cancel) if respond_to(:before_cancel)
        transaction do
          reviews.where(cancelled_at: nil).each { |r| r.update(cancelled_at: Time.now) }
        end
      rescue => e
        e
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
