require 'bundler'
require 'rake/clean'
require 'rake/testtask'
require 'cucumber'
require 'cucumber/rake/task'
gem 'rdoc' # we need the installed RDoc gem, not the system one
require 'rdoc/task'
require 'methadone'
require 'fileutils'

include Rake::DSL
include Methadone::SH
include FileUtils

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.pattern = 'test/tc_*.rb'
end

CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format pretty --no-source -x"
  t.fork = false
end

Rake::RDocTask.new do |rd|
  
  rd.main = "README.rdoc"
  
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
end

task :man do 
  sh 'ronn --markdown --roff man/hl.1.ronn'
  mv 'man/hl.1.markdown','README.md'
end
CLEAN << 'man/hl.1'
CLEAN << 'man/hl.1.html'

task :default => [:test,:features,:man]
