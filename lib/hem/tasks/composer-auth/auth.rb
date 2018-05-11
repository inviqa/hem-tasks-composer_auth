#!/usr/bin/env ruby
# ^ Syntax hint

namespace :auth do
  namespace :composer do
    desc 'Ask for a composer authentication token for fetching private repositories inside the VM'
    task :config, [:domain, :username, :token] do |_task_name, args|
      domain = args[:domain] || 'github-oauth.github.com'
      Hem.ui.section 'Composer Configuration' do
        has_auth_exitcode = run "grep -q '#{domain}' ~/.composer/auth.json",
                                ignore_errors: true, exit_status: true
        has_auth = has_auth_exitcode.zero?
        if has_auth
          Hem.ui.success 'Detected that domain present in ~/.composer/auth.json already!'
        else
          username = Hem.ui.ask('Username for ' + domain, default: args[:username]).to_s unless domain =~ 'github'

          question = 'Authentication Token for ' + domain
          if domain =~ 'github'
            question = 'Github OAuth Token [This can be generated at https://github.com/settings/tokens ]'
          end
          token = Hem.ui.ask(question, default: args[:token]).to_s

          if !username.empty? && !token.empty?
            run php_command("php bin/composer.phar config --global '#{domain}' '#{username}' '#{token}'")
          elsif !token.empty?
            run php_command("php bin/composer.phar config --global '#{domain}' '#{token}'")
          end

          if !token.empty?
            Hem.ui.info 'Skipped composer config as no token provided'
          else
            Hem.ui.success 'Set composer config token in ~/.composer/auth.json'
          end
        end
      end
    end

    desc 'Ask for a composer auth file as JSON, or pick from COMPOSER_AUTH in the environment, '\
         'for fetching private repositories inside the VM'
    task :file do
      Hem.ui.section 'Composer Configuration' do
        auth = ''
        auth = ENV['COMPOSER_AUTH'] if ENV['COMPOSER_AUTH']
        auth = Hem.ui.ask('Composer Auth JSON', default: auth).to_s
        if auth
          require 'shellwords'
          escaped_composer_auth = auth.gsub('"', '\"')
          Hem.ui.section 'Setting up Composer Authentication in ~/.composer/auth.json' do
            run 'mkdir -p ~/.composer/', realtime: true, indent: 2
            run "echo '#{escaped_composer_auth}' > ~/.composer/auth.json", realtime: true, indent: 2
            Hem.ui.success 'Done'
          end
        end
      end
    end
  end
end
