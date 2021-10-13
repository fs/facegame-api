class CreateResult
  class SaveModel
    include Interactor

    delegate :prepared_result_params, to: :context

    def call
      context.result = Result.new(prepared_result_params)

      context.fail!(error_data: error_data) unless context.result.save
    end

    private

    def error_data
      { message: "Record Invalid", detail: context.result.errors.to_a }
    end
  end
end
