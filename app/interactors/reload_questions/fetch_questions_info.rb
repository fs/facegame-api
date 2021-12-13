class ReloadQuestions
  class FetchQuestionsInfo
    include Interactor

    delegate :provider, to: :context

    def call
      context.questions_info = fetch_team_members_info
    end

    private

    def fetch_team_members_info
      @fetch_team_members_info ||= QuestionsGeneration::BaseAdapter.fetch_team_members(provider)
    end
  end
end
