class ReloadQuestions
  class FetchQuestionsInfo
    include Interactor

    def call
      context.questions_info = fetch_questions_info
    end

    private

    def fetch_questions_info
      @fetch_questions_info ||= notion_adapter.fetch_questions
    end

    def notion_adapter
      Notion::Adapter.new
    end
  end
end
