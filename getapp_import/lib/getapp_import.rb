require "getapp_import/version"
require "getapp_import/vendor"
require "getapp_import/source"
require "getapp_import/importer"
require "getapp_import/error"

module GetappImport
  # Class to start data importing process for a vendor
  # 
  class Importer
    def initialize vendor_name=nil, data_source_uri=nil
      raise Error::ParameterNotFoundError,
        "vendor_name" if vendor_name.nil? || vendor_name.empty?
      raise Error::ParameterNotFoundError,
        "data_source_uri" if data_source_uri.nil? || data_source_uri.empty?

      @vendor_name = vendor_name
      @data_source_uri = data_source_uri
    end

    def import
      vendor = Vendor::Vendor.new(
        @vendor_name,
        DataSource.new(@data_source_uri)
      )
      source_data = vendor.read_data_from_source
  
      data_parser = Vendor::SourceDataParser.new(source_data)
      parsed_data = data_parser.parse {|parsed_item|
        DataImporter.single_import(parsed_item)
      }

      # importer.bulk_import(parsed_data)
    end
  end
end
