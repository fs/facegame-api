require "rails_helper"

describe SendAnswerAndGetNextQuestion::SetCorrectAnswersCount do
  include_context "with interactor"

  let(:initial_context) do
    {
      result: result
    }
  end
  let(:result) { create :result }

  before do
    create :answer, result: result, status: "correct"
    create :answer, result: result, status: "correct"
    create :answer, result: result, status: "correct"
    create :answer, result: result, status: "incorrect"
    create :answer, result: result, status: "incorrect"
  end

  describe ".call" do
    it_behaves_like "success interactor"

    it "update correct answers count" do
      interactor.run

      expect(context.correct_answers_count).to eq(3)
    end
  end
end
