require 'simplecov'
SimpleCov.start 'rails' do
  add_filter "lib/tasks/"
  add_filter "app/controllers/"
  add_filter "app/views/"
  add_filter "app/helpers/"
  add_filter "app/channels/application_cable/"
  add_filter "app/jobs/"
  add_filter "app/mailers/"
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest"
require 'minitest/rails'
require 'minitest/reporters'
require 'minitest_extensions'
require 'contexts'


class ActiveSupport::TestCase
    # include the Contexts module for all tests
    include Contexts

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #fixtures :all

  # Add more helper methods to be used by all tests here...


    # Prof. H's helper method to increase readability
    def deny(condition, msg="")
      assert !condition, msg
    end
end
