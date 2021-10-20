class ReloadQuestions
  class CreateOrUpdateQuestions
    include Interactor

    delegate :updatable_questions_info, to: :context

    def call
      save_questions
    end

    private

    def save_questions
      updatable_questions_info.each {|item| find_or_initialize_question(item).save }
    end

    def find_or_initialize_question(item)
      question = Question.find_or_initialize_by(email: item.email)
      question.full_name = item.full_name
      question.department = item.department
      question.avatar = URI.open(item.photo)
      question.discarded_at = nil
      question
    end
  end
end
