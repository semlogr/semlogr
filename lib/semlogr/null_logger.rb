module Semlogr
  class NullLogger
    def debug?
      false
    end

    def info?
      false
    end

    def warn?
      false
    end

    def error?
      false
    end

    def fatal?
      false
    end

    def debug(template = nil, error: nil, **properties, &block)
    end

    def info(template = nil, error: nil, **properties, &block)
    end

    def warn(template = nil, error: nil, **properties, &block)
    end

    def error(template = nil, error: nil, **properties, &block)
    end

    def fatal(template = nil, error: nil, **properties, &block)
    end

    def with_context(**_properties)
      self
    end
  end
end
