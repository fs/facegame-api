class GeneratePopularityRating
  include Interactor

  delegate :current_user, to: :context
  delegate :email, to: :current_user, prefix: true

  def call
    context.data = data if question.present?
  end

  private

  def data
    {
      answers_count: answers_count,
      correct_answers_count: correct_answers_count,
      statistic: statistic,
      avatar_url: question.avatar(:small)&.url
    }
  end

  def statistic
    string = "#{correct_answers_count} of #{answers_count} time"
    if correct_answers_count == 1
      string
    else
      string + "s"
    end
  end

  def answers_count
    answers.count
  end

  def correct_answers_count
    answers.correct.count
  end

  def answers
    @answers ||= Answer.last_week.answered.where(question: question)
  end

  def question
    @question ||=
      Question.find_by("email LIKE ?", prepared_email_query)
  end

  def prepared_email_query
    "#{current_user_email.split('@')[0]}%"
  end
end
