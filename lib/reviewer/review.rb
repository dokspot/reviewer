require 'active_support/concern'

module Reviewer
  module Review
    extend ActiveSupport::Concern

    included do
      belongs_to :item, polymorphic: true
      belongs_to :user, polymorphic: true

      def pending?
        !accepted? && !rejected? && !cancelled?
      end

      def accepted?
        accepted_at? && !cancelled?
      end

      def rejected?
        rejected_at? && !cancelled?
      end

      def cancelled?
        cancelled_at?
      end

      def status
        return :pending   if pending?
        return :accepted  if accepted?
        return :rejected  if rejected?
        return :cancelled if cancelled?
      end

      def status?(query)
        send("#{query}?")
      end

      def accept!
        success = update(accepted_at: Time.now, rejected_at: nil)
      rescue => e
        puts e.message
      end

      def reject!
        update(rejected_at: Time.now, accepted_at: nil)
      rescue => e
        e
      end

      def cancel!
        update(cancelled_at: Time.now)
      rescue => e
        e
      end

    end

    class_methods do
      def accepted
        Object.const_get(name).all.select { |i| i.accepted? }
      end

      def rejected
        Object.const_get(name).all.select { |i| i.rejected? }
      end

      def pending
        Object.const_get(name).all.select { |i| i.pending? }
      end

      def cancelled
        Object.const_get(name).all.select { |i| i.cancelled? }
      end
    end

  end
end
