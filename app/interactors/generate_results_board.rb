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
    ordered_users.first(params[:limit]).each do |item|
      results << {
        score: item.last_result&.score || 0, full_name: item.full_name, rate: i, avatar_url: item.avatar_url
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
      questions_count: current_user.last_result.answers.answered.count,
      correct_answers_count: current_user.last_result.answers.correct.count,
      rate: current_user_rate,
      avatar_url: current_user.avatar_url
    }
  end

  def current_user_rate
    ordered_users.pluck(:id).index(current_user.id) + 1
  end

  def ordered_users
    @ordered_users ||= last_results_of_users.sort_by(&:score).reverse.map(&:user)
  end

  def last_results_of_users
    grouped_finsihed_results.map { |group| group.max_by(&:finish_at) }
  end

  def grouped_finsihed_results
    Result.finished.to_a.group_by(&:user_id).values
  end
end
