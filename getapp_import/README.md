
# GetappImport
Gem for importing data from multiple vendors for Getapp

# Installation
1. Clone the Git repository\
`$ git clone git@github.com:asjabbal/getapp_import.git`
2. Change to the cloned gem directory\
`$ cd getapp_import`
3. Build the gem\
`$ gem build getapp_import.gemspec`
4. Install the gem\
`$ gem install getapp_import-1.0.0.gem`

# Run Tests
Go to main directory of the cloned gem and run tests with the following command:-\
`$ rake test`

# Usage (in two ways you can use this gem)
#### 1. Command-line usage
You can directly use ***getapp_import*** command installed with gem\
`$ getapp_import <vendor_name> <url_or_filepath>`\
\
Example:-\
`$ getapp_import capterra feed_products/capterra.yaml`

#### 2. Programmatic usage
After installing the gem, use it like below:-
```ruby
require "getapp_import"

importer = GetappImport::Importer.new(
    "softwareadvice",                       # vendor name
    "feed-products/softwareadvice.json"     # data filepath or url
)
importer.import # function to import data from filepath or url
```