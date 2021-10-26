require "rails_helper"

describe ReloadQuestions::DeleteArchivedQuestions do
  include_context "with interactor"

  let(:initial_context) { { archived_questions_emails: archived_questions_emails } }

  let!(:question1) { create :question, email: "email1@email.email" }
  let!(:question2) { create :question, email: "email2@email.email" }

  let(:archived_questions_emails) do
    [
      "email1@email.email",
      "email2@email.email"
    ]
  end

  it_behaves_like "success interactor"

  it "archives questions" do
    interactor.run

    expect(Question.kept.count).to be_zero
    expect(Question.discarded).to eq [question1, question2]
  end
end
