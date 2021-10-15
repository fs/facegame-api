module Types
  class ResultsBoardType < Types::BaseObject
    field :top_results, [Types::ResultsBoardItemType], null: false
    field :current_user_result, Types::CurrentUserResultType, null: true
  end
end
