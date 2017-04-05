require 'active_support/concern'

module Reviewer
  module States
    extend ActiveSupport::Concern

    included do
      private_class_method :query

      def state
        self.class.states.each do |s|
          return s if state?(s)
        end
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
