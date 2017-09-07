module Semlogr
  class Error < StandardError
  end

  class ComponentNotRegisteredError < Error
    def initialize(type, key)
      super(":#{key} is not a registered :#{type}")
    end
  end
end
