require "rails_helper"

describe ReloadQuestions::FetchQuestionsInfo do
  include_context "with interactor"

  let(:initial_context) { { provider: provider } }

  let(:expected_data) do
    [
      QuestionsGeneration::BaseAdapter::TeamMember.new
    ]
  end

  let(:provider) { "notion" }

  before do
    allow_any_instance_of(QuestionsGeneration::NotionAdapter).to receive(:fetch_team_members)
      .and_return(expected_data)
  end

  it_behaves_like "success interactor"

  it "gets questions from notion adapter" do
    interactor.run

    expect(context.questions_info).to eq expected_data
  end
end
