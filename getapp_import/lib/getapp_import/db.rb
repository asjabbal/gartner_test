require 'singleton'

module GetappImport
  # Class to make DB connections and execute queries. It's a singleton class - 
  # only single instance will be created.
  class Db
    include Singleton

    def initialize
      @client = nil # connect to mysql or mongodb here
    end

    def execute query
      # execute query here
    end
  end
end