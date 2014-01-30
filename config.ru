# encoding: utf-8
#\ -w
$: << File.expand_path('..', __FILE__)

require 'rubygems' if RUBY_VERSION < '1.9'
require 'bundler/setup'
require 'app/website'

run Rack::URLMap.new({
  "/" => Application::Website,
  "/admin" => Application::Admin
})
