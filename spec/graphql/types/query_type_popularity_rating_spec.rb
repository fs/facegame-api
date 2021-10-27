require "rails_helper"

describe Types::QueryType do
  let(:token_payload) { { type: "access" } }

  let(:user) { create :user, email: email }
  let(:question) { create :question, email: "email@flatstack.com" }
  let(:email) { "email@flatstack.com" }

  let(:query) do
    <<-GRAPHQL
      query {
        popularityRating {
          answersCount
          correctAnswersCount
        }
      }
    GRAPHQL
  end

  before do
    create :answer, question: question, correct: true
    create :answer, question: question, correct: true
    create :answer, question: question, correct: false
    create :answer, correct: true
    create :answer, correct: false
  end

  it_behaves_like "graphql request", "gets popularity info" do
    let(:schema_context) { { current_user: user, token_payload: token_payload.stringify_keys } }
    let(:fixture_path) { "json/acceptance/graphql/query_popularity_rating.json" }
  end

  context "with second email" do
    let(:email) { "email@scalewill.com" }

    it_behaves_like "graphql request", "gets popularity info" do
      let(:schema_context) { { current_user: user, token_payload: token_payload.stringify_keys } }
      let(:fixture_path) { "json/acceptance/graphql/query_popularity_rating.json" }
    end
  end
end
