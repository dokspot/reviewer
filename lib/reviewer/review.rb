require 'active_support/concern'
require 'reviewer/states'

module Reviewer
  module Review
    extend ActiveSupport::Concern
    include Reviewer::States

    included do
      belongs_to :item, polymorphic: true
      belongs_to :user, polymorphic: true

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
      def states
        super + [:pending, :rejected, :accepted, :cancelled]
      end

      def accepted
        query(:accepted)
      end

      def rejected
        query(:rejected)
      end

      def pending
        query(:pending)
      end

      def cancelled
        query(:cancelled)
      end
    end

  end
end
