require "rails_helper"

describe Types::QueryType do
  let(:token_payload) { { type: "access" } }

  let(:user) { create :user, email: email }
  let(:email) { "email@flatstack.com" }

  let(:query) do
    <<-GRAPHQL
      query {
        popularityRating {
          answersCount
          correctAnswersCount
          statistic
          avatarUrl
        }
      }
    GRAPHQL
  end

  context "when question doesn`t exist" do
    it_behaves_like "graphql request", "gets popularity info" do
      let(:schema_context) { { current_user: user, token_payload: token_payload.stringify_keys } }
      let(:fixture_path) { "json/acceptance/graphql/query_popularity_rating_without_question.json" }
    end
  end

  context "when question exists" do
    before do
      create :answer, question: question, status: "correct"
      create :answer, question: question, status: "incorrect"
      create :answer, question: question, status: "incorrect", created_at: 8.days.ago
      create :answer, status: "correct"
      create :answer, status: "incorrect"
    end

    let(:question) { create :question, email: "email@flatstack.com" }
    let(:schema_context) { { current_user: user, token_payload: token_payload.stringify_keys } }
    let(:fixture_path) { "json/acceptance/graphql/popularity_rating_single.json" }

    context "with only one correct answer" do
      let!(:answer) { create :answer, question: question, status: "incorrect" }

      it_behaves_like "graphql request", "gets popularity info"

      context "with second email" do
        let(:email) { "email@scalewill.com" }

        it_behaves_like "graphql request", "gets popularity info"
      end
    end

    context "with more than one correct answers" do
      let(:schema_context) { { current_user: user, token_payload: token_payload.stringify_keys } }
      let(:fixture_path) { "json/acceptance/graphql/popularity_rating_multiple.json" }
      let!(:answer) { create :answer, question: question, status: "correct" }

      it_behaves_like "graphql request", "gets popularity info"

      context "with second email" do
        let(:email) { "email@scalewill.com" }

        it_behaves_like "graphql request", "gets popularity info"
      end
    end
  end
end
