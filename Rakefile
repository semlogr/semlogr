require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop)

RSpec::Core::RakeTask.new('test:unit') do |c|
  c.rspec_opts = '--fail-fast --pattern spec/unit/**{,/*/**}/*_spec.rb'
end

task 'test:performance' do
  Dir['spec/performance/**/*.rb'].each do |file|
    require_relative file
  end
end

task test: %w[test:unit test:performance]
task default: %w[rubocop test]
