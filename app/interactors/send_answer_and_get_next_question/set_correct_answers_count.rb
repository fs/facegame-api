class SendAnswerAndGetNextQuestion
  class SetCorrectAnswersCount
    include Interactor

    delegate :result, to: :context

    def call
      context.correct_answers_count = correct_answers_count
    end

    private

    def correct_answers_count
      @correct_answers_count ||= result.answers.correct.count
    end
  end
end
