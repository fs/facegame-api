class ReloadQuestions
  class FetchQuestionsInfo
    include Interactor

    def call
      context.questions_info = fetch_team_members_info
    end

    private

    def fetch_team_members_info
      @fetch_team_members_info ||= notion_adapter.fetch_team_members
    end

    def notion_adapter
      Notion::Adapter.new
    end
  end
end
