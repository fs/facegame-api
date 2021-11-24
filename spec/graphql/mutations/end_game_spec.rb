require "rails_helper"

describe Mutations::EndGame, type: :request do
  let(:user) { create :user }

  let!(:result) { create :result, finish_at: 10.minutes.since }

  let(:query) do
    <<-GRAPHQL
    mutation {
    endGame(
      input: {
        gameId: #{result.id}
      }
    ) {
        score
        user {
          id
        }
        answers {
          value
          correct
          question {
            id
            fullName
          }
        }
      }
    }
    GRAPHQL
  end
  context "with correct data" do
    let(:schema_context) { { current_user: user } }

    before do
      create :answer, result: result, question_id: 111, value: "Name1"
      create :answer, result: result, question_id: 222, value: "Name1"
      create :answer, result: result, question_id: 333, value: "Name3"
      create :question, id: 111, full_name: "Name1"
      create :question, id: 222, full_name: "Name2"
      create :question, id: 333, full_name: "Name3"
    end

    it_behaves_like "graphql request", "returns updated user info" do
      let(:fixture_path) { "json/acceptance/graphql/end_game/success.json" }
    end
  end
end
