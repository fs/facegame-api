require "rails_helper"

describe SendAnswerAndGetNextQuestion::SetCurrentQuestion do
  include_context "with interactor"

  let(:initial_context) do
    {
      result: result
    }
  end

  let(:result) { create :result }
  let(:question) { create :question }
  let!(:answer) { create :answer, result: result, question: question, status: "pending" }

  describe ".call" do
    it_behaves_like "success interactor"

    it "finds random question" do
      interactor.run

      expect(context.question).to be_present
      expect(context.question).to eq(question)
    end
  end
end
