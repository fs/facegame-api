require "rails_helper"

describe Mutations::StartGame, type: :request do
  let(:user) { create :user }

  let(:execution_context) { { context: { current_user: user } } }
  let(:schema_context) { { current_user: user } }

  let(:image_path) { "spec/fixtures/images/avatar.jpg" }

  let!(:question1) { create :question, full_name: "FullName1" }
  let!(:new_pending_question) { create :question, full_name: "FullName4" }
  let!(:question2) { create :question, full_name: "FullName2" }
  let!(:question3) { create :question, full_name: "FullName3" }

  let(:created_result) { Result.last }

  let(:query) do
    <<-GRAPHQL
    mutation {
      startGame {
        gameId
        question {
          avatarUrl
          answerOptions(sortBy: "id")
        }
        pendingQuestion {
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
    new_pending_question.avatar = File.open(Rails.root.join(image_path), "rb")
    new_pending_question.avatar_derivatives!
    new_pending_question.save
  end

  it_behaves_like "graphql request", "return game_id and question" do
    let(:fixture_path) { "json/acceptance/graphql/start_game/success.json" }

    let(:prepared_fixture_file) do
      fixture_file.gsub(
        /:avatar_url|:game_id|:pending_avatar_url/,
        ":avatar_url" => question3.avatar(:normal).url,
        ":game_id" => created_result.id,
        ":pending_avatar_url" => new_pending_question.avatar(:normal).url
      )
    end
  end
end
