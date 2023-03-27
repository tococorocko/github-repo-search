require 'rails_helper'
require 'services/github/connector'

RSpec.describe "Services::Github::Connector", type: :service do
	describe "search_repositories" do
		let(:query) 		{ "rails" }
		let(:request) 		{ Services::Github::Connector.search_repositories(query) }
		let(:stub_url) 		{ Services::Github::Connector.base_url + "/search/repositories?q=#{query}" }
		let(:body) 			{ "" }
		let(:status) 		{ nil }
		
		before do
			stub_request(:get, stub_url).
			to_return(body: body, status: status)
		end

		context "when query is empty" do
			let(:query) { "" }
			it "returns an error hash" do
				expect(request).to be_a(Hash)
				expect(request[:message]).to eq("Query cannot be empty")
			end
		end

		context "when query is not empty" do
			let(:status) { 200 }
			let(:body) { File.read(Rails.root.join("spec", "fixtures", "query_rails.json")) }

			it "returns a hash" do
				expect(request).to be_a(Hash)
				expect(request["total_count"]).to eq(456300)
				expect(request["items"].count).to eq(30)
			end
		end
		
		context "when API unaivailable (503)" do
			let(:status) { 503 }
			it "returns an error hash" do
				expect(request).to be_a(Hash)
				expect(request[:status_code]).to eq(503)
				expect(request[:message]).to eq("Service unavailable")
			end
		end
			
		context "when API limit reached (422)" do
			let(:status) { 422 }
			it "returns an error hash" do
				expect(request).to be_a(Hash)
				expect(request[:status_code]).to eq(422)
				expect(request[:message]).to eq("Rate limit exceeded")
			end
		end
	end
end