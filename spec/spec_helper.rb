$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

if !ENV["CI"]
  require "simplecov"
  SimpleCov.start
end

require "nested_attributes_serializer"

begin
  require "pry"
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

def gem_root
  File.expand_path(File.join(File.dirname(__FILE__), ".."))
end
