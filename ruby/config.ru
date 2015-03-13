require 'rubygems'
require 'bundler'
Bundler.setup

log = File.new("log/development.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

$stderr.sync = true
$stdout.sync = true

require 'sinatra'
require './sample_bots.rb'

run Sinatra::Application