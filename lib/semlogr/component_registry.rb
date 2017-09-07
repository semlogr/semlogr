require 'semlogr/error'

module Semlogr
  class ComponentRegistry
    @mappings = {}

    def self.register(type, mapping)
      (@mappings[type] ||= {}).update(mapping)
    end

    def self.resolve(type, key, *params)
      mapping = @mappings[type] && @mappings[type][key]
      raise ComponentNotRegisteredError.new(type, key) unless mapping

      mapping.new(*params)
    end
  end
end
