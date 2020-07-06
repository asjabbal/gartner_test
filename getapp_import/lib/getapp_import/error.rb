module GetappImport
  module Error
    class Error < StandardError; end

    class InvalidVendor < Error
      def initialize vendor=""
        super(%Q{Invalid vendor '#{vendor}'})
      end
    end

    class InvalidVendorDataType < Error
      def initialize args
        super(%Q{Invalid data type '#{args[:data_type]}' for vendor  '#{args[:vendor]}'})
      end
    end

    class InvalidDataUri < Error
      def initialize uri=""
        super(%Q{Invalid data filepath or url '#{uri}'})
      end
    end
  end
end