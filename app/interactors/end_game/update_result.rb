class EndGame
  class UpdateResult
    include Interactor

    delegate :result, to: :context

    def call
      result.update(result_params)
    end

    private

    def result_params
      {
        finish_at: Time.current,
      }
    end
  end
end
