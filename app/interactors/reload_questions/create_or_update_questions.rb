class ReloadQuestions
  class CreateOrUpdateQuestions
    include Interactor

    delegate :updatable_questions_info, to: :context

    def call
      Question.import(save_questions, on_duplicate_key_update: :all)
    end

    private

    def save_questions
      updatable_questions_info.map {|item| find_or_initialize_question(item) }
    end

    def find_or_initialize_question(item)
      question = Question.find_or_initialize_by(email: item.email)
      question.full_name = item.full_name
      question.department = item.department
      question.avatar = URI.open(item.photo) if question.avatar_name != item.avatar_name
      question.avatar_name = item.avatar_name
      question.discarded_at = nil
      question.avatar_derivatives!
      question
    end
  end
end
