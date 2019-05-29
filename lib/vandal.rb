require 'vandal/version'

module Vandal
  module Destroy
    extend ::ActiveSupport::Concern

    def vandal_destroy
      @destroying ||= false
      return if @destroying
      @destroying = true
      self.class.transaction do
        self.class.related_associations.each do |association|
          related = send(association[:name])
          related.send("vandal_destroy#{association[:collection] ? '_all' : ''}") if related.present?
        end
        delete
      end
    ensure
      @destroying = false
    end

    module ClassMethods
      def vandal_destroy_all
        transaction { find_each { |r| r.vandal_destroy } }
      end

      def related_associations
        @related_associations ||= reflections.collect do |name, association|
          { name: name, collection: association.collection? }
        end
      end
    end
  end
end

class ActiveRecord::Base
  include Vandal::Destroy
end
