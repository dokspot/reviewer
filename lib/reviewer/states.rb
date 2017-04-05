require 'active_support/concern'

module Reviewer
  module States
    extend ActiveSupport::Concern

    included do
      private_class_method :query

      def state
        # States set by the states method will have higher priority
        active = nil
        self.class.states.each do |s|
          active = s if state?(s)
        end
        active
      end

      def state?(query)
        send("#{query}?")
      end

    end

    class_methods do
      def states
        []
      end

      def query(state)
        all.select { |i| i.send("#{state}?")}
      end
    end

  end
end
