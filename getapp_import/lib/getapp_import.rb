require "getapp_import/version"
require "getapp_import/vendor"
require "getapp_import/source"
require "getapp_import/importer"
require "getapp_import/error"

module GetappImport
  # Class to start data importing process from a vendor
  # It requires +vendor_name+ (string) and +data_source_uri+ (string)
  # for the importing process.
  class Importer
    def initialize vendor_name=nil, data_source_uri=nil
      raise Error::ParameterNotFoundError,
        "vendor_name" if vendor_name.nil? || vendor_name.empty?
      raise Error::ParameterNotFoundError,
        "data_source_uri" if data_source_uri.nil? || data_source_uri.empty?

      @vendor_name = vendor_name
      @data_source_uri = data_source_uri
    end

    # Method to start the data importing process
    def import
      # create a new vendor
      vendor = Vendor::Vendor.new(
        @vendor_name,
        DataSource.new(@data_source_uri)
      )
      # read data from the source given by vendor
      source_data = vendor.read_data_from_source
  
      # parse the source data
      data_parser = Vendor::SourceDataParser.new(source_data)
      parsed_data = data_parser.parse {|parsed_item|
        DataImporter.single_import(parsed_item) # import single parsed item
      }

      # import bulk parsed data
      # parsed_data = data_parser.parse
      # DataImporter.bulk_import(parsed_data)
    end
  end
end
