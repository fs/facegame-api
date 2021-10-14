class GenerateResultsBoard
  include Interactor

  delegate :params, :current_user, to: :context

  def call
    context.data = data
  end

  private

  def data
    {
      top_results: top_results,
      current_user_result: current_user_result
    }
  end

  def top_results
    i = 1
    results = []
    ordered_users.limit(params[:limit]).each do |item|
      results << {
        score: item.last_result&.score || 0,
        full_name: item.full_name,
        rate: i
      }
      i += 1
    end
    results
  end

  def current_user_result
    return nil if current_user.last_result.blank?

    {
      score: current_user.last_result.score,
      full_name: current_user.full_name,
      questions_count: current_user.last_result.answers.count,
      correct_answers_count: current_user.last_result.answers.correct.count,
      rate: current_user_rate
    }
  end

  def current_user_rate
    ordered_users.ids.index(current_user.id) + 1
  end

  def ordered_users
    @ordered_users ||= User
      .order("last_score DESC")
  end
end
