require 'bundler'
Bundler.require :default

base = File.dirname(__FILE__)
$:.unshift File.join(base, "lib")

require 'superpacman'

Sinatra::Base.set(:root) { base }
run SuperPacMan::Application

