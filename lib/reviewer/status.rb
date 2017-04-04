require 'active_support/concern'

module Reviewer
  module Status
    extend ActiveSupport::Concern

    included do
      private_class_method :query

      def status
        states.each do |s|
          return s if status?(s)
        end
      end

      def status?(query)
        send("#{query}?")
      end

    end

    class_methods do
      def query(status)
        all.select { |i| i.send("#{status}?")}
      end
    end

  end
end
