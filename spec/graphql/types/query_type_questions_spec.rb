require "rails_helper"

describe Types::QueryType do
  let!(:user) { create :user, email: "primary@email.ru" }
  let(:token_payload) { { type: "access" } }

  let(:query) do
    <<-GRAPHQL
      query {
        questions(sortBy: "id", limit: 2) {
          id
          email
          fullName
          department
          avatarUrl
          wrongAnswers(sortBy: "id", limit: 3)
        }
      }
    GRAPHQL
  end

  before do
    create :question, email: "primary@email.ru"
    create :question, email: "email1@example.com", full_name: "Name1"
    create :question, email: "email2@example.com", full_name: "Name2"
    create :question, email: "email3@example.com", full_name: "Name3"
    create :question, email: "email4@example.com", full_name: "Name4"
    create :question, email: "email5@example.com", full_name: "Name5"
  end

  it_behaves_like "graphql request", "gets current_user info" do
    let(:schema_context) { { current_user: user, token_payload: token_payload.stringify_keys } }
    let(:fixture_path) { "json/acceptance/graphql/query_questions.json" }
  end

  context "with unauthenticated user" do
    it_behaves_like "graphql request", "gets current_user info" do
      let(:fixture_path) { "json/acceptance/graphql/query_questions_wrong.json" }
    end
  end
end
