require 'rest-client'
require 'json'

namespace :sentry do
  task :notify_deployment do
    url = "#{fetch(:sentry_endpoint)}#{fetch(:sentry_organization)}/releases/"
    token = fetch(:sentry_token)
    projects = fetch(:sentry_projects)

    payload = { version: "#{fetch(:branch_tag).strip!}-#{fetch(:current_version)}".sub(/^-/, ''),
                url: "#{fetch(:sentry_git_compare_url)}#{fetch(:previous_revision)}...#{fetch(:current_version)}",
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
