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
  let(:answer) { create :answer, value: "Arthur Zaharov", status: "correct" }
  let(:correct_answer_value) { "Arthur Zaharov" }

  describe ".call" do
    context "when answer is not correct" do
      let(:answer_value) { "Denis Zaharov" }

      it_behaves_like "success interactor"

      it "update previous answer" do
        interactor.run

        expect(answer).to have_attributes(
          value: "Denis Zaharov",
          status: "incorrect"
        )
      end
    end

    context "when answer is correct" do
      let(:answer_value) { correct_answer_value }

      it_behaves_like "success interactor"

      it "update previous answer" do
        interactor.run

        expect(answer).to have_attributes(
          value: "Arthur Zaharov",
          status: "correct"
        )
      end
    end
  end
end
