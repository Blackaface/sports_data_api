require "sports_data_api"

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require 'webmock/rspec'
require 'vcr'

def load_xml(filename)
  File.read("#{File.dirname(__FILE__)}/xml/#{filename}.xml")
end

def schedule_xml
  load_xml("schedule")
end

def boxscore_xml
  load_xml("boxscore")
end

def api_key
  key = 'VALID_SPORTS_DATA_API_KEY'
  key = ENV['SPORTS_DATA_API_KEY'] if ENV.has_key?('SPORTS_DATA_API_KEY')
  key
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.preserve_exact_body_bytes { true }
  c.configure_rspec_metadata!

  ##
  # Filter the real API key so that it does not make its way into the VCR cassette
  c.filter_sensitive_data('<API_KEY>')  { api_key }
end
