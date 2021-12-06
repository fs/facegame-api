require "rails_helper"

describe Mutations::EndGame, type: :request do
  let(:user) { create :user, id: 111 }

  let(:execution_context) { { context: { current_user: user } } }
  let(:schema_context) { { current_user: user } }

  let!(:result) { create :result, finish_at: 10.minutes.since, user: user, score: 133 }

  let(:query) do
    <<-GRAPHQL
    mutation {
    endGame(
      input: {
        gameId: #{result.id}
      }
    ) {
        score
      }
    }
    GRAPHQL
  end

  before do
    create :question, id: 111, full_name: "Name1"
    create :question, id: 222, full_name: "Name2"
    create :question, id: 333, full_name: "Name3"
    create :answer, result: result, question_id: 111, value: "Name1", status: "correct"
    create :answer, result: result, question_id: 222, value: "Name1", status: "incorrect"
    create :answer, result: result, question_id: 333, value: "Name3", status: "correct"
  end

  it_behaves_like "graphql request", "returns updated user info" do
    let(:fixture_path) { "json/acceptance/graphql/end_game/success.json" }
  end
end
