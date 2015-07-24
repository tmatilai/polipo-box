require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Run all tests'
task default: [:foodcritic, :spec, :rubocop]

FoodCritic::Rake::LintTask.new

desc 'Run ChefSpec unit tests'
RSpec::Core::RakeTask.new

RuboCop::RakeTask.new
