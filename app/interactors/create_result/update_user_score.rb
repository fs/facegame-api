class CreateResult
  class UpdateUserScore
    include Interactor

    delegate :result, :current_user, to: :context
    delegate :score, to: :result, prefix: true

    def call
      current_user.update(last_score: result_score)
    end
  end
end
