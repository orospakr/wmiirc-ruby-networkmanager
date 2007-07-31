require 'rake'
require 'spec/rake/spectask'

# # add lib directory, because we'll be running the tests without actually being
# # installed. :)
# # $:.unshift('./lib')
# current_dir = File.dirname(__FILE__)
# lib_dir = File.expand_path("#{current_dir}/lib")
# p lib_dir
# $:.unshift(lib_dir)
# $LOAD_PATH.unshift(lib_dir)

# require 'networkmanager'

desc 'run rake tasks'
Spec::Rake::SpecTask.new('specs') do |t|
  t.spec_files = FileList['spec/*-spec.rb']
  t.spec_opts = ['-f', 's']
  #t.rcovf = true
end

desc 'run rake tasks, and output html'
Spec::Rake::SpecTask.new('html') do |t|
  t.spec_files = FileList['spec/*-spec.rb']
  t.spec_opts = ['-f', 'html:spec.html']
end
