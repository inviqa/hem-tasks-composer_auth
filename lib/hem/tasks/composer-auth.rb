#!/usr/bin/env ruby
# ^ Syntax hint

namespace :deps do
  require_relative 'composer-auth/auth'
end

def php_command(args)
  args.to_s
end
