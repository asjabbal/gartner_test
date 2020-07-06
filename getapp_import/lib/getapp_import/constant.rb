# frozen_string_literal: true

module GetappImport
  VENDOR_CAPTERRA = "capterra"
  VENDOR_SOFTADV = "softwareadvice"

  SUPPORTED_VENDORS = [VENDOR_CAPTERRA, VENDOR_SOFTADV]

  TYPE_YAML = :yaml
  TYPE_JSON = :json
  TYPE_CSV = :csv
  TYPE_FILE = :file
  TYPE_URL = :url

  SUPPORTED_VENDOR_DATA_TYPES = {
    VENDOR_CAPTERRA => [TYPE_YAML],
    VENDOR_SOFTADV => [TYPE_JSON]
  }

  KEY_NAME = "Name"
  KEY_CATEGORIES = "Categories"
  KEY_TWITTER = "Twitter"
end