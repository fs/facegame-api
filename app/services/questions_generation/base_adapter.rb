# frozen_string_literal: true

module QuestionsGeneration
  class BaseAdapter
    TeamMember = Struct.new(
      :email,
      :full_name,
      :department,
      :photo,
      :archived,
      :avatar_name,
      :gender,
      keyword_init: true
    )

    def self.fetch_team_members(provider)
      "QuestionsGeneration::#{provider.titleize}Adapter".constantize.new.fetch_team_members
    end

    def fetch_team_members
      team_members_params.map { |team_member_params| TeamMember.new(team_member_params) }
    end

    private

    def team_members_params
      raise NotImplementedError
    end
  end
end
