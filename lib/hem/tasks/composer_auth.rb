#!/usr/bin/env ruby
# ^ Syntax hint

desc 'Install dependencies'
namespace :deps do
  require_relative 'composer_auth/auth'
end

def php_command(args)
  args.to_s
end
