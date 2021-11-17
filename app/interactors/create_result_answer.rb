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
      question: question,
      result: result
    }
  end

  def error_data
    { message: "Answer can't save" }
  end
end
