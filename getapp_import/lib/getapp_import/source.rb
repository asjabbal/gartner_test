require 'getapp_import/reader'
require 'getapp_import/constant'
require 'getapp_import/error'

module GetappImport
  require 'open-uri'
  
  class DataSource
    attr_reader :data_type
  
    def initialize source=nil
      @source = source
      set_source_type
      set_uri
      set_data_type
    end
  
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
  
    def set_uri
      @uri =  begin
                URI.open(@source)
              rescue Errno::ENOENT => exception
                nil
              end

      raise Error::InvalidDataUriError, @source if @uri.nil?
    end
  
    def set_data_type
      @data_type =  case @source_type
                    when TYPE_FILE
                      file_extension
                    when TYPE_URL
                      url_content_type
                    end
    end
  
    def file_extension
      File.extname(@uri).gsub(".", "").to_sym
    end
  
    def url_content_type
      case @uri.content_type
      when /csv/
        TYPE_CSV
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