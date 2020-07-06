require 'getapp_import/reader'
require 'getapp_import/constant'
require 'getapp_import/error'

module GetappImport
  require 'open-uri'
  
  # Class to fetch and read data from supported data sources and of supported data
  # types. Data source can either be a file or an url.
  # Params:-
  #   +source+ (string) : filepath or url
  #   +source_type+ (symbol) : defines if source is a file or an url
  #   +uri+ (object) : defines parsed source filepath or url
  #   +data_type+ (symbol) : defines the kind of data source has - yaml, json, csv
  class DataSource
    attr_reader :data_type
  
    def initialize source=nil
      @source = source
      set_source_type
      set_uri
      set_data_type
    end
  
    # Method to fetch data from data source based on it's data type
    def fetch_data
      @fetched_data ||= case @data_type
                        when TYPE_YAML
                          read_yaml
                        when TYPE_JSON
                          read_json
                        when TYPE_CSV
                          read_csv
                        end
  
      @fetched_data
    end
  
    private
    def set_source_type
      if @source.match(/http:|https:/)
        @source_type = TYPE_URL
      else
        @source_type = TYPE_FILE
      end
    end
  
    # This method parses any file type and any http/https url and sets +uri+
    def set_uri
      @uri =  begin
                URI.open(@source)
              rescue Errno::ENOENT => exception
                nil
              end

      raise Error::InvalidDataUriError, @source if @uri.nil?
    end
  
    # This method sets data type based on the file extension or url content type
    def set_data_type
      @data_type =  case @source_type
                    when TYPE_FILE
                      file_extension
                    when TYPE_URL
                      url_content_type
                    end
    end
  
    # Method to get file extension
    def file_extension
      File.extname(@uri).gsub(".", "").to_sym
    end
  
    # Method to get content type of an url
    # Currently supported types for an url are - :csv
    # Add more types here to enable them for source url
    def url_content_type
      case @uri.content_type
      when /csv/
        TYPE_CSV
      # when /json/
      #   TYPE_JSON
      # when /xml/
      #   TYPE_XML
      else
        @uri.content_type
      end
    end
  
    def read_yaml
      Reader::YamlReader.read(@uri)
    end
  
    def read_json
      Reader::JsonReader.read(@uri)
    end
  
    def read_csv
      Reader::CsvReader.read(@uri)
    end
  end
end