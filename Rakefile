# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'bundler/setup'
require './app/website'
require 'sinatra/activerecord/rake'

Dir[File.expand_path('../tasks/*.rake', __FILE__)].each {|f| Rake.application.add_import f }
