require "getapp_import/constant"

module GetappImport
  # Super parser class
  # params:-
  #   +data+ (hash or array) : raw source data
  #   +data_type+ (symbol) : based on this specific parser method gets called
  class Parser
    def initialize data=nil, data_type=nil
      @data = data
      @data_type = data_type    
    end
  
    def parse &block
      send("parse_#{@data_type.to_s}".to_sym, &block)
    end
  end

  # SdParser module contains source data parser classes for supported vendors.
  module SdParser

    # Data parser class for Capterra vendor.
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

    # Data parser class for Softwareadvice vendor.
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