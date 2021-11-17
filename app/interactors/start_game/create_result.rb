class StartGame
  class CreateResult
    include Interactor

    delegate :current_user, to: :context

    def call
      context.result = result
      context.fail!(error_data: error_data) unless result.save
    end

    private

    def result
      @result ||= Result.new(result_params)
    end

    def result_params
      {
        user: current_user,
        finish_at: ENV.fetch("GAME_TIME_SECONDS", 55).to_i.second.since
      }
    end

    def error_data
      { message: "Record Invalid", detail: context.result.errors.to_a }
    end
  end
end
