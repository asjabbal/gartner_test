module GetappImport
  # Reader module contains different reader classes for different data types.
  module Reader

    class YamlReader
      require 'yaml'

      def self.read uri
        if uri.kind_of?(File)
          YAML.load_file(uri)
        else
          YAML.load_file(uri.read)
        end    
      end
    end

    class JsonReader
      require 'json'

      def self.read uri
        JSON.parse(uri.read)
      end
    end

    class CsvReader
      require 'csv'
      
      def self.read uri
        if uri.kind_of?(File)
          CSV.read(uri)
        else
          CSV.parse(uri)
        end
      end
    end

  end
end