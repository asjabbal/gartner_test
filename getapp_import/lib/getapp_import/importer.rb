require "getapp_import/constant"
require "getapp_import/db"

module GetappImport

  # Class to save parsed vendor data into DB
  # It offers both single import and bulk import functionalities
  class DataImporter

    # Function to save single data item to DB
    def self.single_import data
      puts %Q{importing: Name: "#{data[KEY_NAME]}";  Categories: #{data[KEY_CATEGORIES].join(", ")}; Twitter: #{data[KEY_TWITTER]}}

      query = nil # generate query here
      Db.instance.execute query
    end

    # Function for bulk insert into DB
    def self.bulk_import data
      query = nil # generate query here
      Db.instance.execute query
    end
  end
end