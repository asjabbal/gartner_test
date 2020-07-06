require 'singleton'

module GetappImport
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