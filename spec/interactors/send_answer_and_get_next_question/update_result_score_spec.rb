require "rails_helper"

describe SendAnswerAndGetNextQuestion::UpdateResultScore do
  include_context "with interactor"

  let(:initial_context) do
    {
      result: result
    }
  end

  let!(:result) { create :result, score: 0 }
  let!(:correct_answer1) { create :answer, result: result, correct: true }
  let!(:correct_answer2) { create :answer, result: result, correct: true }
  let!(:correct_answer3) { create :answer, result: result, correct: true }
  let!(:correct_answer4) { create :answer, result: result, correct: false }
  let!(:correct_answer5) { create :answer, result: result, correct: false }
  let(:answers_count) { result.answers.count }

  describe ".call" do
    it_behaves_like "success interactor"

    it "update result score" do
      interactor.run

      expect(result).to have_attributes(
        score: 180
      )
    end
  end
end
