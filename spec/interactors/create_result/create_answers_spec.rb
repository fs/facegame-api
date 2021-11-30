require "rails_helper"

describe CreateResult::CreateAnswers do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { prepared_answers_params: prepared_answers_params, result: result } }

  let(:prepared_answers_params) do
    [
      {
        status: "correct", question_id: 111, value: "Name1"
      },
      {
        status: "correct", question_id: 222, value: "Name2"
      },
      {
        status: "incorrect", question_id: 333, value: "Name4"
      }
    ]
  end

  let!(:result) { create :result, score: 1000, user: user }
  let(:user) { create :user }

  before do
    create :question, id: 111, full_name: "Name1"
    create :question, id: 222, full_name: "Name2"
    create :question, id: 333, full_name: "Name3"
  end

  describe ".call" do
    it_behaves_like "success interactor"

    it "creates result" do
      interactor.run

      expect(Answer.count).to eq 3
      expect(Answer.pluck(:status)).to eq %w[correct correct incorrect]
    end
  end
end
