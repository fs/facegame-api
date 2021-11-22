require "rails_helper"

describe SendAnswerAndGetNextQuestion::PrepareParams do
  include_context "with interactor"

  let(:initial_context) do
    {
      current_user: current_user,
      params: params
    }
  end
  let(:current_user) { create :user }
  let(:params) { { game_id: result.id, value: "Denis Zaharov" } }
  let!(:result) { create :result, finish_at: 10.minutes.since, user: current_user }
  let!(:answer) { create :answer, value: nil, correct: false, question: question, result: result }
  let(:question) { create :question, full_name: "Arthur Zaharov" }

  describe ".call" do
    it_behaves_like "success interactor"

    it "prepares params" do
      interactor.run

      expect(context.answer_value).to eq("Denis Zaharov")
      expect(context.result).to eq(result)
      expect(context.answer).to eq(answer)
      expect(context.correct_answer_value).to eq("Arthur Zaharov")
    end
  end
end
