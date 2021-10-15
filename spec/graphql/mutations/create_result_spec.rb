require "rails_helper"

describe Mutations::CreateResult do
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
    let(:schema_context) { { current_user: user } }

    before do
      create :question, id: 111, full_name: "Name1"
      create :question, id: 222, full_name: "Name2"
      create :question, id: 333, full_name: "Name3"
    end

    it_behaves_like "graphql request", "returns updated user info" do
      let(:fixture_path) { "json/acceptance/graphql/create_result/success.json" }
    end
  end

  context "with empty answers" do
    let(:schema_context) { { current_user: user } }

    let(:query) do
      <<-GRAPHQL
        mutation {
          createResult (
            input: {
              answers: []
            }
          ) {
            score
            answers {
              value
            }
          }
        }
      GRAPHQL
    end

    it_behaves_like "graphql request", "returns updated user info" do
      let(:fixture_path) { "json/acceptance/graphql/create_result/empty_answers.json" }
    end
  end

  context "with incorrect data" do
    let(:schema_context) { { current_user: user } }

    before do
      create :question, id: 111, full_name: "Name1"
      create :question, id: 222, full_name: "Name2"
    end

    it_behaves_like "graphql request", "returns updated user info" do
      let(:fixture_path) { "json/acceptance/graphql/create_result/incorrect_data.json" }
    end
  end

  context "when unauthorized" do
    before do
      create :question, id: 111, full_name: "Name1"
      create :question, id: 222, full_name: "Name2"
      create :question, id: 333, full_name: "Name3"
    end

    it_behaves_like "graphql request", "returns updated user info" do
      let(:fixture_path) { "json/acceptance/graphql/create_result/unauthorized.json" }
    end
  end
end
