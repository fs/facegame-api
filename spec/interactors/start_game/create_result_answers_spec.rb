require "rails_helper"

describe StartGame::CreateResultAnswers do
  include_context "with interactor"

  let(:initial_context) do
    {
      question: question,
      pending_question: pending_question,
      result: result
    }
  end

  let(:question) { create :question }
  let(:pending_question) { create :question }
  let(:result) { create :result }
  let(:current_answer) { Answer.current.last }
  let(:pending_answer) { Answer.pending.last }

  describe ".call" do
    it_behaves_like "success interactor"

    it "creates result answers" do
      interactor.run

      expect(current_answer).to be_present
      expect(pending_answer).to be_present
      expect(current_answer).to have_attributes(
        status: "current",
        question: question,
        result: result
      )
      expect(pending_answer).to have_attributes(
        status: "pending",
        question: pending_question,
        result: result
      )
    end
  end
end
