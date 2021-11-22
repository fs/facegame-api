require "rails_helper"

describe SendAnswerAndGetNextQuestion::PrepareQuestionParams do
  include_context "with interactor"

  let(:initial_context) do
    {
      current_user: current_user,
      result: result
    }
  end
  let!(:result) { create :result }
  let!(:answer_1) { create :answer, result: result, correct: false, question: question_1 }
  let(:question_1) { create :question, id: 111 }
  let!(:answer_2) { create :answer, result: result, correct: false, question: question_2 }
  let(:question_2) { create :question, id: 232 }
  let(:current_user) { create :user }
  let(:filter_options) do
    {
      excluded_email: current_user.email,
      excluded_question_ids: excluded_question_ids
    }
  end
  let(:excluded_question_ids) { [111, 232] }

  describe ".call" do
    it_behaves_like "success interactor"

    it "prepares question params" do
      interactor.run

      expect(context.filter_options).to eq(filter_options)
    end
  end
end
