require "getapp_import/version"
require "getapp_import/vendor"
require "getapp_import/source"
require "getapp_import/importer"

module GetappImport
  class Importer
    def initialize vendor_name=nil, data_source_uri=nil
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
