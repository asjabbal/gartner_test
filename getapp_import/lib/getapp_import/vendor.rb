module GetappImport
  module Vendor
    require 'getapp_import/constant'

    class Vendor
      require 'getapp_import/error'

      def initialize name=nil, data_source=nil
        @name = name
        @data_source = data_source
    
        raise Error::InvalidVendorError, @name if !valid_vendor?
        raise Error::InvalidVendorDataTypeError,
          {vendor: @name, data_type: @data_source.data_type} if !valid_data_type_for_vendor?
      end
    
      def read_data_from_source
        data = @data_source.fetch_data

        @source_data ||= SourceData.new(@name, data, @data_source.data_type)
        @source_data
      end
    
      private
      def valid_vendor?
        SUPPORTED_VENDORS.include?(@name)
      end
    
      def valid_data_type_for_vendor?
        SUPPORTED_VENDOR_DATA_TYPES[@name].include?(@data_source.data_type)
      end
    end

    class SourceData
      attr_reader :vendor_name, :data, :data_type
    
      def initialize vendor_name=nil, data=nil, data_type=nil
        @vendor_name = vendor_name
        @data = data
        @data_type = data_type
      end
    end

    class SourceDataParser
      require 'getapp_import/parser'
      
      def initialize source_data=nil
        @source_data = source_data
      end
    
      def parse &block
        @parser ||= case @source_data.vendor_name
                    when VENDOR_CAPTERRA
                      SdParser::CapterraParser.new(@source_data.data,
                        @source_data.data_type)
                    when VENDOR_SOFTADV
                      SdParser::SoftwareadviceParser.new(@source_data.data,
                        @source_data.data_type)
                    end
    
        @parsed_data = @parser.parse &block
        
        @parsed_data
      end
    end
  end
end