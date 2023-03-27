require "services/application_service"

module Services
	module Github
		class Connector < Services::ApplicationService
			
			GithubRateLimitError = Class.new(StandardError)
			InvalidRequestError = Class.new(StandardError)
			GithubConnectionError = Class.new(StandardError)

			def self.search_repositories(query, additional_headers = {})
				raise InvalidRequestError.new("Query cannot be empty") if query.blank?
				response = HTTParty.get(
					self.base_url + "/search/repositories?q=#{query}",
					{
						headers: self.base_headers.merge(additional_headers)
					}
				)
				if response.code == 422
					raise GithubRateLimitError.new("Rate limit exceeded")
				elsif response.code == 503
					raise GithubConnectionError.new("Service unavailable")
				end

				parsed_response = JSON.parse(response.body)
				parsed_response[:status_code] = 200
				return parsed_response
			rescue => e
				# TODO: Exception handling like Honeybadger
				return {
					status_code: response.try(:code) || 500,
					message: e.try(:message) || "Something went wrong"
				}
			end

			def self.base_url
				"https://api.github.com"
			end

			def self.base_headers
				{
					"Accept" => "application/vnd.github+json",
					"X-GitHub-Api-Version" => "2022-11-28"
				}
			end
		end
	end
end