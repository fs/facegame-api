# frozen_string_literal: true

require "rails_helper"

describe Notion::Client do
  let(:service) { described_class.new }

  describe "#fetch_data" do
    subject(:fetch_data) { service.fetch_data }

    let(:body) { "{}" }
    let(:headers) { { "Authorization" => "Bearer token", "Content-Type" => "application/json" } }

    it "sends request" do
      expect(described_class).to receive(:post).with("/v1/databases/database_id/query", body: body, headers: headers)

      fetch_data
    end

    context "when cursor is defined" do
      subject(:fetch_data) { service.fetch_data("abcdefgh") }

      let(:body) { "{\"start_cursor\":\"abcdefgh\"}" }

      it "sends request with cursor" do
        expect(described_class).to receive(:post).with("/v1/databases/database_id/query", body: body, headers: headers)

        fetch_data
      end
    end
  end
end
