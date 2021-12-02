require "rails_helper"

describe SendAnswerAndGetNextQuestion::FindRandomQuestion do
  include_context "with interactor"

  let(:initial_context) do
    {
      question: question,
      filter_options: filter_options
    }
  end

  let(:current_user) { create :user }
  let(:filter_options) do
    {
      excluded_email: current_user.email,
      excluded_question_ids: [111]
    }
  end

  let!(:question1) { create :question, email: current_user.email }
  let!(:question) { create :question, id: 111 }
  let!(:pending_question) { create :question }

  describe ".call" do
    it_behaves_like "success interactor"

    it "finds random question" do
      interactor.run

      expect(context.pending_question).to be_present
      expect(context.pending_question).to eq(pending_question)
    end
  end
end
