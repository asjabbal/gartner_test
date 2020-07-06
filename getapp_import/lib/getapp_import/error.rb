module GetappImport
  module Error
    class Error < StandardError; end

    class InvalidVendorError < Error
      def initialize vendor=""
        super(%Q{Invalid vendor '#{vendor}'})
      end
    end

    class InvalidVendorDataTypeError < Error
      def initialize args
        super(%Q{Invalid data type '#{args[:data_type]}' for vendor  '#{args[:vendor]}'})
      end
    end

    class InvalidDataUriError < Error
      def initialize uri=""
        super(%Q{Invalid data filepath or url '#{uri}'})
      end
    end

    class ParameterNotFoundError < Error
      def initialize param=""
        super(%Q{parameter '#{param}' not found})
      end
    end
  end
end