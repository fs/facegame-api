require "rails_helper"

describe ReloadQuestions::PrepareParams do
  include_context "with interactor"

  let(:initial_context) { { questions_info: questions_info } }

  let(:archived_team_member1) do
    QuestionsGeneration::BaseAdapter::TeamMember.new(
      archived: true,
      email: "email1@email.email",
      full_name: "Full name1",
      department: "ios",
      photo: "photo",
      gender: "female"
    )
  end

  let(:archived_team_member2) do
    QuestionsGeneration::BaseAdapter::TeamMember.new(
      archived: true,
      email: "email2@email.email",
      full_name: "Full name2",
      department: "ios",
      photo: "photo",
      gender: "male"
    )
  end

  let(:active_team_member1) do
    QuestionsGeneration::BaseAdapter::TeamMember.new(
      archived: false,
      email: "email3@email.email",
      full_name: "Full name3",
      department: "ios",
      photo: "photo",
      gender: "male"
    )
  end

  let(:active_team_member2) do
    QuestionsGeneration::BaseAdapter::TeamMember.new(
      archived: false,
      email: "email4@email.email",
      full_name: "Full name4",
      department: "ios",
      photo: "photo",
      gender: "female"
    )
  end

  let(:questions_info) do
    [
      archived_team_member1,
      archived_team_member2,
      active_team_member1,
      active_team_member2
    ]
  end

  let(:expected_updatable_questions_info) do
    [
      active_team_member1,
      active_team_member2
    ]
  end

  let(:expected_archived_questions_emails) do
    [
      "email1@email.email",
      "email2@email.email"
    ]
  end

  it_behaves_like "success interactor"

  it "prepares data about team members" do
    interactor.run

    expect(context.updatable_questions_info).to eq expected_updatable_questions_info
    expect(context.archived_questions_emails).to eq expected_archived_questions_emails
  end
end
