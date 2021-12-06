require "graphql/batch"

class ApplicationSchema < GraphQL::Schema
  disable_introspection_entry_points if Rails.env.production?
  
  mutation(Types::MutationType)
  query(Types::QueryType)

  use GraphQL::Execution::Errors
  use GraphQL::Execution::Interpreter
  use GraphQL::Pagination::Connections
  use GraphQL::Analysis::AST
  use GraphQL::Batch

  rescue_from(ActionPolicy::Unauthorized) do |exp|
    raise GraphQL::ExecutionError.new(
      exp.result.message,
      extensions: {
        code: :unauthorized,
        status: 401,
        detail: exp.result.reasons.details
      }
    )
  end

  rescue_from(ActiveRecord::RecordNotFound) do |_err, _obj, _args, _ctx, field|
    raise GraphQL::ExecutionError.new("#{field.type.unwrap.graphql_name} not found",
                                      extensions: { message: "Not Found", status: 404, code: :not_found })
  end
end
