# frozen_string_literal: true

module QuestionsGeneration
  class NotionAdapter < BaseAdapter
    private

    def team_members_params
      team_members_data.map { |team_member_data| team_member_params(team_member_data) }
    end

    def team_members_data
      questions = []
      has_more = true
      cursor = nil
      while has_more
        response = client.fetch_data(cursor).deep_symbolize_keys
        questions += response[:results]
        has_more = response[:has_more]
        cursor = response[:next_cursor]
      end
      questions
    end

    def client
      @client ||= Notion::Client.new
    end

    def team_member_params(data)
      {
        email: email_from_data(data),
        full_name: full_name_from_data(data),
        department: department_from_data(data),
        photo: photo_from_data(data),
        avatar_name: avatar_name_from_data(data),
        archived: archived_from_data(data),
        gender: gender_from_data(data)
      }
    end

    def gender_from_data(data)
      data.dig(:properties, :Gender, :select, :name)&.downcase
    end

    def email_from_data(data)
      data.dig(:properties, :"Work Email", :email)
    end

    def full_name_from_data(data)
      data.dig(:properties, :"Full name", :title, 0, :plain_text)
    end

    def department_from_data(data)
      data.dig(:properties, :Department, :select, :name)
    end

    def photo_from_data(data)
      data.dig(:properties, :Photo, :files, 0, :file, :url)
    end

    def avatar_name_from_data(data)
      data.dig(:properties, :Photo, :files, 0, :name)
    end

    def archived_from_data(data)
      data.dig(:properties, :Inactive, :checkbox) || data.dig(:archived)
    end
  end
end
