require "rails_helper"

describe Types::QueryType do
  let!(:user) { create :user, email: "primary@flatstack.com" }
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
    create :question, email: "primary@flatstack.com", gender: "male"
    create :question, email: "primary@scalewill.com", gender: "male"
    create :question, email: "email1@flatstack.com", full_name: "Name1", gender: "male", id: 111
    create :question, email: "email2@flatstack.com", full_name: "Name2", gender: "male", id: 222
    create :question, email: "email3@flatstack.com", full_name: "Name3", gender: "female", id: 333
    create :question, email: "email4@flatstack.com", full_name: "Name4", gender: "male", id: 444
    create :question, email: "email5@flatstack.com", full_name: "Name5", gender: "male", id: 555
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
