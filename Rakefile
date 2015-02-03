require 'bundler'

Bundler.require :default, :development, :test

$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')

Rake::TaskManager.record_task_metadata = true
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc 'Tests'
task test: [:spec]
