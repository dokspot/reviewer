require 'active_support/concern'
require 'reviewer/status'

module Reviewer
  module Review
    extend ActiveSupport::Concern
    include Reviewer::Status

    included do
      belongs_to :item, polymorphic: true
      belongs_to :user, polymorphic: true

      def states
        [:pending, :rejected, :accepted, :cancelled]
      end

      def pending?
        !accepted? && !rejected? && !cancelled?
      end

      def accepted?
        accepted_at? && !cancelled? && !rejected_at?
      end

      def rejected?
        rejected_at? && !cancelled? && !accepted_at?
      end

      def cancelled?
        cancelled_at?
      end

      # def status
      #   return :pending   if pending?
      #   return :accepted  if accepted?
      #   return :rejected  if rejected?
      #   return :cancelled if cancelled?
      # end
      #
      # def status?(query)
      #   send("#{query}?")
      # end

      def accept!
        update(accepted_at: Time.now, rejected_at: nil)
      rescue => e
        e
      end

      def reject!
        update(rejected_at: Time.now, accepted_at: nil)
      rescue => e
        e
      end

      def cancel!
        update(cancelled_at: Time.now) unless cancelled_at?
      rescue => e
        e
      end

    end

    class_methods do

      def accepted
        # all.select { |i| i.accepted? }
        query(:accepted)
      end

      def rejected
        # all.select { |i| i.rejected? }
        query(:rejected)
      end

      def pending
        # all.select { |i| i.pending? }
        query(:pending)
      end

      def cancelled
        # all.select { |i| i.cancelled? }
        query(:cancelled)
      end
    end

  end
end
