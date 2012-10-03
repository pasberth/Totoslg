require 'ostruct'

module Totoslg

  module MasterData

    def self.included klass

      klass.instance_eval do

        def define id, attributes = {}
          id = id.to_sym
          model = find_or_create_by_identifier(id)
          model.identifier = id

          attributes.each do |attr, val|
            if model.respond_to?(:"_create_#{attr}")
              (field_name, field_val = model.send(:"_create_#{attr}", val)) or next
              model.send(:"#{field_name}=", field_val)
            else
              raise "#{model.class} has'nt :\"_create_#{attr}\" method."
            end
          end

          model.save
        end

        def [] id
          find_by_identifier(id.to_sym)
        end
      end
    end
  end
end
