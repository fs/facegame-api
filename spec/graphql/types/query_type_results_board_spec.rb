require "rails_helper"

describe Types::QueryType do
  let(:token_payload) { { type: "access" } }

  let!(:user) { create :user, last_score: 133, first_name: "Sommer", last_name: "Celena" }

  let(:user1) { create :user, last_score: 150, first_name: "Jaunita", last_name: "Desirae" }
  let(:user2) { create :user, last_score: 400, first_name: "Rosalva", last_name: "Lashay" }
  let(:user3) { create :user, last_score: 500, first_name: "Rochell", last_name: "Jon" }
  let(:user4) { create :user, last_score: 100 }

  let(:current_user_result) { create :result, score: 133, user: user }

  let(:query) do
    <<-GRAPHQL
      query {
        resultsBoard(limit: 3) {
          topResults {
            rate
            fullName
            score
            avatarUrl
          }
          currentUserResult {
            rate
            fullName
            score
            questionsCount
            correctAnswersCount
            avatarUrl
          }
        }
      }
    GRAPHQL
  end

  before do
    create :result, score: 100, user: user1
    create :result, score: 200, user: user1
    create :result, score: 150, user: user1
    create :result, score: 400, user: user2
    create :result, score: 500, user: user3
    create :result, score: 100, user: user4

    create :answer, result: current_user_result, status: "correct"
    create :answer, result: current_user_result, status: "correct"
    create :answer, result: current_user_result, status: "incorrect"
  end

  it_behaves_like "graphql request", "gets results info" do
    let(:schema_context) { { current_user: user, token_payload: token_payload.stringify_keys } }
    let(:fixture_path) { "json/acceptance/graphql/query_results_board.json" }
  end
end
