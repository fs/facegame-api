module Mutations
  class SendAnswerAndGetNextQuestion < BaseMutation
    include AuthenticableGraphqlUser

    argument :input, Types::AnswerAndNewQuestionInput, required: true

    type Types::SendAnswerAndGetNextQuestionType

    def resolve(input:)
      result = ::SendAnswerAndGetNextQuestion.call(
        current_user: context[:current_user],
        params: input.to_h
      )

      if result.success?
        result
      else
        execution_error(error_data: result.error_data)
      end
    end
  end
end
