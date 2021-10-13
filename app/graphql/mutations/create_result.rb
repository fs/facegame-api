module Mutations
  class CreateResult < BaseMutation
    include AuthenticableGraphqlUser

    argument :input, Types::CreateResultInput, required: true

    type Types::ResultType

    def resolve(input:)
      create_result = ::CreateResult.call(
        current_user: context[:current_user], params: input.to_h
      )

      if create_result.success?
        create_result.result
      else
        execution_error(error_data: create_result.error_data)
      end
    end
  end
end
