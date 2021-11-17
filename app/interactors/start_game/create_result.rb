class StartGame
  class CreateResult
    include Interactor

    delegate :current_user, to: :context

    def call
      context.result = create_result
      context.fail!(error_data: error_data) unless result.save
    end

    private

    def create_result
      @result ||= Result.new(result_params)
    end
    
    def result_params
      {
        user: current_user,
        finished_at: ENV.fetch("GAME_TIME", 55).to_i.second.since
      }
    end

    def error_data
      { message: "Result can't save" }
    end
  end
end
