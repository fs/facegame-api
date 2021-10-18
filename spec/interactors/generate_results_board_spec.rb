require "rails_helper"

describe GenerateResultsBoard do
  include_context "with interactor"

  let(:initial_context) { { current_user: user, params: params } }

  let(:user) { create :user, last_score: 133, first_name: "Sommer", last_name: "Celena" }
  let(:params) { { limit: 3 } }

  let(:user1) { create :user, last_score: 150, first_name: "Jaunita", last_name: "Desirae" }
  let(:user2) { create :user, last_score: 400, first_name: "Rosalva", last_name: "Lashay" }
  let(:user3) { create :user, last_score: 500, first_name: "Rochell", last_name: "Jon" }
  let(:user4) { create :user, last_score: 100 }

  let(:current_user_result) { create :result, score: 133, user: user }

  let(:expected_data) do
    {
      current_user_result: current_user_result_data,
      top_results: top_results
    }
  end

  let(:top_results) do
    [
      {
        full_name: "Rochell Jon",
        rate: 1,
        score: 500,
        avatar_url: nil
      },
      {
        full_name: "Rosalva Lashay",
        rate: 2,
        score: 400,
        avatar_url: nil
      },
      {
        full_name: "Jaunita Desirae",
        rate: 3,
        score: 150,
        avatar_url: nil
      }
    ]
  end

  let(:current_user_result_data) do
    {
      correct_answers_count: 2,
      full_name: "Sommer Celena",
      questions_count: 3,
      rate: 4,
      score: 133,
      avatar_url: nil
    }
  end

  before do
    create :result, score: 100, user: user1
    create :result, score: 200, user: user1
    create :result, score: 150, user: user1
    create :result, score: 400, user: user2
    create :result, score: 500, user: user3
    create :result, score: 100, user: user4

    create :answer, result: current_user_result, correct: true
    create :answer, result: current_user_result, correct: true
    create :answer, result: current_user_result, correct: false
  end

  describe ".call" do
    it_behaves_like "success interactor"

    it "creates user" do
      interactor.run

      expect(context.data).to eq expected_data
    end
  end
end
