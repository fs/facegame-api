class EndGame
  class PrepareParams
    include Interactor

    delegate :game_id, :current_user, to: :context

    def call
      context.fail!(error_data: error_data) if result.blank?

      context.result = result
    end

    private

    def result
      @result ||= Result.active.find_by(user: current_user, id: game_id)
    end

    def error_data
      { message: "Result not found", code: :not_found, status: 404 }
    end
  end
end
