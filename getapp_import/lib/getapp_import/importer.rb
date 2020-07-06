require "getapp_import/constant"
require "getapp_import/db"

module GetappImport
  class DataImporter
    def self.single_import data
      puts %Q{importing: Name: "#{data[KEY_NAME]}";  Categories: #{data[KEY_CATEGORIES].join(", ")}; Twitter: #{data[KEY_TWITTER]}}

      query = nil # generate query here
      Db.instance.execute query
    end

    def self.bulk_import data
      query = nil # generate query here
      Db.instance.execute query
    end
  end
end