#!/usr/bin/env ruby
# ^ Syntax hint

namespace :auth do
  desc 'Ask for a git oauth token for fetching private repositories inside the VM'
  task :composer_github do
    Hem.ui.section 'Composer Configuration' do
      has_auth_exitcode = run 'grep -q github.com /home/vagrant/.composer/auth.json',
                              ignore_errors: true, exit_status: true
      has_auth = has_auth_exitcode.zero?
      if has_auth
        Hem.ui.success 'Detected that oauth token present in /home/vagrant/.composer/auth.json already!'
      else
        oauth_token = Hem.ui.ask(
          'Github OAuth Token [This can be generated at https://github.com/settings/tokens ]',
          default: ''
        ).to_s
        run "php bin/composer.phar config --global github-oauth.github.com '#{oauth_token}'" unless oauth_token.empty?
        if !oauth_token.empty?
          Hem.ui.info 'Skipped oauth token as none provided'
        else
          Hem.ui.success 'Set oauth token in /home/vagrant/.composer/auth.json'
        end
      end
    end
  end
end

namespace :deps do
  task :composer_auth do
    if ENV['COMPOSER_AUTH']
      require 'shellwords'
      escaped_composer_auth = ENV['COMPOSER_AUTH'].gsub('"', '\"')
      Hem.ui.section 'Setting up Composer Authentication in ~/.composer/auth.json' do
        run "mkdir -p ~/.composer/", realtime: true, indent: 2
        run "echo '#{escaped_composer_auth}' > ~/.composer/auth.json", realtime: true, indent: 2
        Hem.ui.success 'Done'
      end
    end
  end
end
