# frozen_string_literal: true

module Notion
  class Adapter
    TeamMember = Struct.new(
      :email,
      :full_name,
      :department,
      :photo,
      :archived,
      :avatar_name,
      :gender,
      keyword_init: true
    ) do
      def fetch_team_members
        team_members
      end

      private

      def team_members
        team_data.map do |item|
          TeamMember.new(
            team_member_params(item)
          )
        end
      end

      def team_data
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

      def team_member_params(data)
        {
          email: get_email_from_data(data),
          full_name: get_full_name_from_data(data),
          department: get_department_from_data(data),
          photo: get_photo_from_data(data),
          avatar_name: get_avatar_name_from_data(data),
          archived: get_archived_from_data(data),
          gender: get_gender_from_data(data)
        }
      end

      def get_gender_from_data(data)
        data["properties"]
          .fetch("Gender", {})
          .fetch("select", {})
          .fetch("name", nil)&.downcase
      end

      def get_email_from_data(data)
        data["properties"]
          .fetch("Work Email", {})
          .fetch("email", nil)
      end

      def get_full_name_from_data(data)
        data["properties"]
          .fetch("Full name", {})
          .fetch("title", [])
          .fetch(0, {})
          .fetch("plain_text", nil)
      end

      def get_department_from_data(data)
        data["properties"]
          .fetch("Department", {})
          .fetch("select", {})
          .fetch("name", nil)
      end

      def get_photo_from_data(data)
        data["properties"]
          .fetch("Photo", {})
          .fetch("files", [])
          .fetch(0, {})
          .fetch("file", {})
          .fetch("url", nil)
      end

      def get_avatar_name_from_data(data)
        data["properties"].fetch("Photo", {})
          .fetch("files", [])
          .fetch(0, {})
          .fetch("name", nil)
      end

      def get_archived_from_data(data)
        data["properties"]
          .fetch("Inactive", {})
          .fetch("checkbox", false) || data.fetch("archived", false)
      end
    end
  end
end
