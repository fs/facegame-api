require "rails_helper"

describe Mutations::SendAnswerAndGetNextQuestion, type: :request do
  let(:user) { create :user }

  let(:execution_context) { { context: { current_user: user } } }
  let(:schema_context) { { current_user: user } }

  let(:image_path) { "spec/fixtures/images/avatar.jpg" }

  let(:old_question) { create :question, full_name: "FullName1" }
  let(:new_current_question) { create :question, full_name: "FullName2" }
  let(:new_pending_question) { create :question }
  let(:question) { create :question, full_name: "Ural Sadritdinov" }
  let(:result) { create :result, user: user, finish_at: 10.minutes.since }
  let!(:answer_1) { create :answer, status: "current", result: result, question: question }
  let!(:answer_2) { create :answer, status: "correct", result: result, question: old_question }

  let(:query) do
    <<-GRAPHQL
    mutation {
    sendAnswerAndGetNextQuestion(
      input: {
        gameId: #{result.id},
        value: "Ural Sadritdinov"
      }
    ) {
        correctAnswersCount
        correctAnswerValue
        question {
          answerOptions
          avatarUrl
        }
        pendingQuestion {
          avatarUrl
        }
      }
    }
    GRAPHQL
  end

  before do
    create :answer, status: "pending", result: result, question: new_current_question
    create :question, full_name: "FullName3"
    new_current_question.avatar = File.open(Rails.root.join(image_path), "rb")
    new_current_question.avatar_derivatives!
    new_current_question.save
    new_pending_question.avatar = File.open(Rails.root.join(image_path), "rb")
    new_pending_question.avatar_derivatives!
    new_pending_question.save
    srand(777)
  end

  it_behaves_like "graphql request", "return correct_answer_value, correct_answers_count and question" do
    let(:fixture_path) { "json/acceptance/graphql/send_answer_and_get_next_question/success.json" }

    let(:prepared_fixture_file) do
      fixture_file.gsub(
        /:pendingAvatarUrl|:currentAvatarUrl/,
        ":pendingAvatarUrl" => new_pending_question.avatar(:normal).url,
        ":currentAvatarUrl" => new_current_question.avatar(:normal).url
      )
    end
  end
end
