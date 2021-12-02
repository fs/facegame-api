require "rails_helper"

describe SendAnswerAndGetNextQuestion::CreateResultAnswer do
  include_context "with interactor"

  let(:initial_context) do
    {
      pending_question: pending_question,
      result: result
    }
  end

  let(:pending_question) { create :question }
  let(:result) { create :result }
  let(:pending_answer) { Answer.last }

  describe ".call" do
    it_behaves_like "success interactor"

    it "creates result answers" do
      interactor.run

      expect(pending_answer).to be_present
      expect(pending_answer).to have_attributes(
        status: "pending",
        question: pending_question,
        result: result
      )
    end
  end
end
