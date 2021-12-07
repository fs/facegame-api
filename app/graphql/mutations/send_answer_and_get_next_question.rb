module Mutations
  class SendAnswerAndGetNextQuestion < BaseMutation
    include AuthenticableGraphqlUser

    argument :input, Types::AnswerAndNewQuestionInput, required: true

    type Types::SendAnswerAndGetNextQuestionType

    def resolve(input:)
      result = Result.active.find_by(id: input[:game_id])
      authorize! result, to: :update? if result

      result = ::SendAnswerAndGetNextQuestion.call(
        current_user: context[:current_user],
        params: input.to_h
      )

      result.success? ? result : execution_error(error_data: result.error_data)
    end
  end
end
