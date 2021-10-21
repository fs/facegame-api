class ReloadQuestions
  class DeleteArchivedQuestions
    include Interactor

    delegate :archived_questions_emails, to: :context

    def call
      archivable_questions.find_each(&:discard)
    end

    private

    def archivable_questions
      Question.kept.where(email: archived_questions_emails)
    end
  end
end
