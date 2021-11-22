require "rails_helper"

describe SendAnswerAndGetNextQuestion::UpdatePreviousAnswer do
  include_context "with interactor"

  let(:initial_context) do
    {
      answer_value: answer_value,
      answer: answer,
      correct_answer_value: correct_answer_value
    }
  end
  let(:answer_value) { "Denis Zaharov" }
  let(:answer) { create :answer, value: "Arthur Zaharov", correct: true }
  let(:correct_answer_value) { "Arthur Zaharov" }

  describe ".call" do
    it_behaves_like "success interactor"

    it "update previous answer" do
      interactor.run

      expect(answer).to have_attributes(
        value: "Denis Zaharov",
        correct: false
      )
    end
  end
end
