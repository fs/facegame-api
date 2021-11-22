require "rails_helper"

describe Mutations::SendAnswerAndGetNextQuestion, type: :request do
  let(:user) { create :user }

  let(:execution_context) { { context: { current_user: user } } }
  let(:schema_context) { { current_user: user } }

  let(:image_path) { "spec/fixtures/images/avatar.jpg" }

  let!(:question1) { create :question, full_name: "FullName1" }
  let!(:question2) { create :question, full_name: "FullName2" }
  let!(:question3) { create :question, full_name: "FullName3" }
  let!(:question4) { create :question, full_name: "FullName4" }

  let!(:result) { create :result, id: 35, user: user, finish_at: 10.minutes.since }
  let!(:correct_answer) { create :answer, correct: false, result: result, question: question3, value: nil }

  let(:query) do
    <<-GRAPHQL
    mutation {
    sendAnswerAndGetNextQuestion(
      input: {
        gameId: 35,
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
    srand(777)
    question3.avatar = File.open(Rails.root.join(image_path), "rb")
    question3.avatar_derivatives!
    question3.save
  end

  it_behaves_like "graphql request", "return correct_answer_value and question" do
    let(:fixture_path) { "json/acceptance/graphql/send_answer_and_get_next_question/success.json" }

    let(:prepared_fixture_file) do
      fixture_file.gsub(
        /:avatar_url|:correct_answer_value/,
        ":avatar_url" => question3.avatar(:normal).url,
        ":correct_answer_value" => correct_answer.question.full_name
      )
    end
  end
end
