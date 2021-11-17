require "rails_helper"

describe StartGame::PrepareParams do
  include_context "with interactor"

  let(:initial_context) {  }
  
  it_behaves_like "success interactor"

  it "prepares data about team members" do
    interactor.run

    expect(context.updatable_questions_info).to eq expected_updatable_questions_info
    expect(context.archived_questions_emails).to eq expected_archived_questions_emails
  end
end