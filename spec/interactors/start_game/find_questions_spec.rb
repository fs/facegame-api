require "rails_helper"

describe StartGame::FindQuestions do
  include_context "with interactor"

  let(:initial_context) do
    {
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
  let!(:question2) { create :question, id: 111 }
  let!(:question3) { create :question, id: 222 }
  let!(:pending_question) { create :question, id: 333 }

  describe ".call" do
    it_behaves_like "success interactor"

    it "finds random questions" do
      interactor.run

      expect(question3).not_to eq(pending_question)
      expect(context.question).to be_present
      expect(context.pending_question).to be_present
      expect(context.question).to eq(question3)
      expect(context.pending_question).to eq(pending_question)
    end
  end
end
