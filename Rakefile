require 'bundler/gem_tasks'

require 'rake/testtask'

task default: :test

desc 'Run Cardgate unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = false
end
