require 'active_support/concern'

module Reviewer
  module Status
    extend ActiveSupport::Concern

    included do
      private_class_method :query
      # puts "states:"
      # puts "self.class.name: #{self.class.name}"

      def status
        self.class.states.each do |s|
          return s if status?(s)
        end
      end

      def status?(query)
        send("#{query}?")
      end

    end

    class_methods do
      # def states
      #   []
      # end

      # self.class.states.each do |s|
      #   define_method(s, query(s))
      # end

      def query(status)
        all.select { |i| i.send("#{status}?")}
      end
    end

  end
end
