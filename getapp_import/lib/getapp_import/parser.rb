require "getapp_import/constant"

module GetappImport
  class Parser
    def initialize data=nil, data_type=nil
      @data = data
      @data_type = data_type    
    end
  
    def parse &block
      send("parse_#{@data_type.to_s}".to_sym, &block)
    end
  end

  module SdParser
    class CapterraParser < GetappImport::Parser
      private
      def parse_yaml &block
        parsed_data = []
        @data.each{|d|
          parsed_data_item = {
            KEY_NAME       => d["name"],
            KEY_CATEGORIES => d["tags"].split(","),
            KEY_TWITTER    => "@#{d["twitter"]}"
          }

          parsed_data << parsed_data_item
          yield(parsed_data_item) if block_given?
        }
    
        parsed_data
      end
    end

    class SoftwareadviceParser < GetappImport::Parser
      private
      def parse_json &block
        parsed_data = []
        @data["products"].each{|d|
          parsed_data_item = {
            KEY_NAME       => d["title"],
            KEY_CATEGORIES => d["categories"],
            KEY_TWITTER    => d["twitter"]
          }

          parsed_data << parsed_data_item
          yield(parsed_data_item) if block_given?
        }
    
        parsed_data
      end
    end
  end
end