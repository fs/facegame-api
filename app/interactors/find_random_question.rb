class FindRandomQuestion
  include Interactor
  
  delegate :filter_options, to: :context

  def call
    context.fail!(error_data: error_data) if question.nil?
    context.question = question
  end

  private

  def question
    @question ||= FilteredQuestionQuery.new(raw_relation, filter_options).all.sample
  end

  def raw_relation
    Question.kept
  end

  def error_data
    {message: "No answers available"}
  end
end
