require 'vandal/version'
require 'pry-byebug'

module Vandal
  module Destroy
    extend ::ActiveSupport::Concern
    DELETE_OPTIONS = [:destroy, :delete, :delete_all]

    def vandal_destroy
      begin
        @destroying ||= false
        return if @destroying
        @destroying = true
        self.class.transaction do
          self.class.related_associations.each do |association|
            related = self.send(association[:name])
            related.send("vandal_destroy#{association[:collection] ? '_all': ''}") if related.present?
          end
          self.delete
        end
      ensure
        @destroying = false
      end
    end

    module ClassMethods
      def vandal_destroy_all
        transaction { find_each { |r| r.vandal_destroy! } }
      end

      def related_associations
        @related_associations ||= reflections.select do |name, association|
          association.options[:dependent].in?(DELETE_OPTIONS)
        end.collect { |name, association| { name: name, collection: association.collection? } }
      end
    end
  end
end

class ActiveRecord::Base
  include Vandal::Destroy
end
