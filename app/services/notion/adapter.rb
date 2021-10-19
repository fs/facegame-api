# frozen_string_literal: true

module Notion
  class Adapter
    def fetch_questions
      team_members
    end

    private

    def team_members
      get_team_data.map { |item| TeamMember.new(item) }
    end

    def get_team_data
      response = client.fetch_data
      questions = response["results"]
      while response["has_more"]
        response = client.fetch_data(response["next_cursor"])
        questions += response["results"]
      end
      questions
    end

    def client
      @client ||= Notion::Client.new
    end
  end
end
