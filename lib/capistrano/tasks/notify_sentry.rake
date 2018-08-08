require 'rest-client'
require 'json'

SENTRY_ENDPOINT = 'https://sentry.io/api/0/organizations/'.freeze

namespace :sentry do
  task :notify_deployment do
    url = "#{SENTRY_ENDPOINT}#{fetch(:sentry_organization)}/releases/"
    token = fetch(:sentry_token)
    projects = fetch(:sentry_projects)

    payload = { version: "#{fetch(:branch_tag).strip!}-#{fetch(:current_version)}".sub(/^-/, ''),
                projects: projects }

    json_payload = JSON.generate(payload)

    puts 'Notify Sentry Release start ....'

    run_locally do
      begin
        response = RestClient.post(url, json_payload,
                                   content_type: 'application/json',
                                   authorization: "Bearer #{token}")

        puts "Sentry response: #{response.body}"
      rescue StandardError => e
        puts e
      end
    end
  end

  after 'deploy:publishing', :'sentry:notify_deployment'
end
