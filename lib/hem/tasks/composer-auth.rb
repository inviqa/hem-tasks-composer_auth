#!/usr/bin/env ruby
# ^ Syntax hint

require_relative '../lib/patches/rake'

namespace :deps do
  require_relative 'composer-auth/auth'
end
after 'tools:composer', 'deps:auth:composer'
