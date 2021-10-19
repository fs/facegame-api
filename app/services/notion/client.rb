# frozen_string_literal: true

module Notion
  class Client
    include HTTParty

    base_uri ENV.fetch("NOTION_API_URL")

    def fetch_data(cursor = nil)
      self.class.post(database_path, body: request_body(cursor).to_json, headers: request_headers)
    end

    private

    def request_headers
      {
        "Authorization" => "Bearer #{token}",
        "Content-Type" => "application/json"
      }
    end

    def request_body(cursor)
      cursor.present? ? { start_cursor: cursor } : {}
    end

    def database_path
      "/v1/databases/#{team_directory_database_id}/query"
    end

    def team_directory_database_id
      ENV.fetch("NOTION_TEAM_DIRECTORY_DATABASE_ID")
    end

    def token
      ENV.fetch("NOTION_AUTH_TOKEN")
    end
  end
end
