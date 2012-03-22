$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/lib')).uniq!

require 'rubygems'
require 'bundler'
require 'sinatra'

Bundler.require

set :env,  :production
disable :run

require "./server"

run Sinatra::Application
