class CreateResultAnswer
  include Interactor

  delegate :question, :result, to: :context

  def call
    context.fail!(error_data: error_data) unless answer.save
  end

  private

  def answer
    @answer ||= Answer.new(answer_params)
  end

  def answer_params
    {
      correct: false,
      question: question,
      result: result
    }
  end

  def error_data
    { message: "Record Invalid", detail: context.result.errors.to_a }
  end
end
