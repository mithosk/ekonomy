ENV["RAILS_ENV"] ||= "test"

require "minitest/mock"
require "rails/test_help"
require_relative "../config/environment"

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)

    fixtures :all
  end
end
