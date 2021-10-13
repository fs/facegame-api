require "rails_helper"

describe Mutations::CreateResult do
  let(:schema_context) { { current_user: user } }
  let(:user) { create :user }

  let(:query) do
    <<-GRAPHQL
      mutation {
        createResult (
          input: {
            answers: [
              {
                questionId: 111,
                value: "Name1"
              },
              {
                questionId: 222,
                value: "Name2"
              },
              {
                questionId: 333,
                value: "Name4"
              }
            ]
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
    before do
      create :question, id: 111, full_name: "Name1"
      create :question, id: 222, full_name: "Name2"
      create :question, id: 333, full_name: "Name3"
    end

    it_behaves_like "graphql request", "returns updated user info" do
      let(:fixture_path) { "json/acceptance/graphql/create_result/success.json" }
    end
  end
end
