require "rails_helper"

describe CreateResultAnswer do
  include_context "with interactor"

  let(:initial_context) do
    {
      question: question,
      result: result
    }
  end

  let(:question) { create :question }
  let(:result) { create :result }
  let(:answer) { Answer.last }

  describe ".call" do
    it_behaves_like "success interactor"

    it "creates result answer" do
      interactor.run

      expect(answer).to be_present
      expect(answer).to have_attributes(
        status: "pending",
        question: question,
        result: result
      )
    end
  end
end
