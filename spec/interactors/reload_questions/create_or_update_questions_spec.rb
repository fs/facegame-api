require "rails_helper"

describe ReloadQuestions::CreateOrUpdateQuestions do
  include_context "with interactor"

  let(:initial_context) { { updatable_questions_info: updatable_questions_info } }

  let(:image_path) { "spec/fixtures/images/avatar.jpg" }

  let(:active_team_member1) do
    QuestionsGeneration::BaseAdapter::TeamMember.new(
      archived: false,
      email: "email3@email.email",
      full_name: "Full name3",
      department: "ios",
      avatar_name: "avatar_1",
      gender: "male",
      photo: File.open(Rails.root.join(image_path), "rb")
    )
  end

  let(:active_team_member2) do
    QuestionsGeneration::BaseAdapter::TeamMember.new(
      archived: false,
      email: "email4@email.email",
      full_name: "Full name4",
      department: "ios",
      avatar_name: "avatar_2",
      gender: "female",
      photo: File.open(Rails.root.join(image_path), "rb")
    )
  end

  let(:updatable_questions_info) do
    [
      active_team_member1,
      active_team_member2
    ]
  end

  let(:question1) { Question.first }
  let(:question2) { Question.second }

  before do
    create :question, email: "email4@email.email", full_name: "Old Name"
  end

  it_behaves_like "success interactor"

  it "creates and updates questions" do
    interactor.run

    expect(question1).to have_attributes(
      discarded_at: nil,
      email: "email4@email.email",
      full_name: "Full name4",
      department: "ios",
      gender: "female"
    )
    expect(question1.avatar(:normal).url).not_to be_nil
    expect(question2).to have_attributes(
      discarded_at: nil,
      email: "email3@email.email",
      full_name: "Full name3",
      department: "ios",
      gender: "male"
    )
    expect(question2.avatar(:normal).url).not_to be_nil
  end
end
