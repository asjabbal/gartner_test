module GetappImport
  module Vendor
    require 'getapp_import/constant'

    # Class to create a vendor and fetch data from the supplied data source.
    # To check supported vendors and data types look into 'contstant.rb'
    # Params:-
    #  +name+ (string) : name of the vendor
    #  +data_source+ (DataSource) : object of DataSource class
    class Vendor
      require 'getapp_import/error'

      def initialize name=nil, data_source=nil
        @name = name
        @data_source = data_source
    
        raise Error::InvalidVendorError, @name if !valid_vendor?
        raise Error::InvalidVendorDataTypeError,
          {vendor: @name, data_type: @data_source.data_type} if !valid_data_type_for_vendor?
      end
    
      # Method to fetch data from the source and return fetched data using object
      # of data wrapper class SourceData
      def read_data_from_source
        data = @data_source.fetch_data

        @source_data ||= SourceData.new(@name, data, @data_source.data_type)
        @source_data
      end
    
      private
      # Method to check if vendor is supported or not
      def valid_vendor?
        SUPPORTED_VENDORS.include?(@name)
      end
    
      # Method to check if data type of supplied source for a vendor is supported
      # or not
      def valid_data_type_for_vendor?
        SUPPORTED_VENDOR_DATA_TYPES[@name].include?(@data_source.data_type)
      end
    end

    # Data wrapper class for vendor fetched data from source
    # Params:-
    #   +vendor_name+ (string) : name of the vendor
    #   +data+ (hash or array) : raw source data
    #   +data_type+ (symbol) : defines source data's data type
    class SourceData
      attr_reader :vendor_name, :data, :data_type
    
      def initialize vendor_name=nil, data=nil, data_type=nil
        @vendor_name = vendor_name
        @data = data
        @data_type = data_type
      end
    end

    # Class to parse raw source data for a vendor
    # Params:-
    #   +source_data+ (SourceData) : object of SourceData class
    class SourceDataParser
      require 'getapp_import/parser'
      
      def initialize source_data=nil
        @source_data = source_data
      end
    
      # Method to parse raw source data for a vendor and returns parsed data 
      # based on the data type and given parsing rules
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