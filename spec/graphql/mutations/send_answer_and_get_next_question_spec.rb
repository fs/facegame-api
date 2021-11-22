require "rails_helper"

describe Mutations::SendAnswerAndGetNextQuestion, type: :request do
  include_context "with stubbed activerecord default order", model: Question, order: { full_name: :asc }
  let(:user) { create :user }

  let(:execution_context) { { context: { current_user: user } } }
  let(:schema_context) { { current_user: user } }

  let(:image_path) { "spec/fixtures/images/avatar.jpg" }

  let(:question) { create :question, full_name: "FullName3" }
  let(:result) { create :result, user: user, finish_at: 10.minutes.since }
  let!(:answer) { create :answer, correct: false, result: result, question: question, value: nil }

  let(:query) do
    <<-GRAPHQL
    mutation {
    sendAnswerAndGetNextQuestion(
      input: {
        gameId: #{result.id},
        value: "Ural Sadritdinov"
      }
    ) {
        correctAnswerValue
        question {
          answerOptions
          avatarUrl
        }
      }
    }
    GRAPHQL
  end

  before do
    create :question, full_name: "FullName1"
    create :question, full_name: "FullName2"
    create :question, full_name: "FullName4"
    srand(777)
    question.avatar = File.open(Rails.root.join(image_path), "rb")
    question.avatar_derivatives!
    question.save
  end

  it_behaves_like "graphql request", "return correct_answer_value and question" do
    let(:fixture_path) { "json/acceptance/graphql/send_answer_and_get_next_question/success.json" }

    let(:prepared_fixture_file) do
      fixture_file.gsub(
        /:avatar_url|:correct_answer_value/,
        ":avatar_url" => question.avatar(:normal).url,
        ":correct_answer_value" => answer.question.full_name
      )
    end
  end
end
