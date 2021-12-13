require "rails_helper"

describe QuestionsGeneration::NotionAdapter do
  let(:team_members_data) do
    {
      "results" => [
        {
          "properties" => {
            "Work Email" => {
              "email" => "email1@email.email"
            },
            "Gender" => {
              "select" => {
                "name" => "Male"
              }
            },
            "Full name" => {
              "title" => [
                {
                  "plain_text" => "Full Name"
                }
              ]
            },
            "Department" => {
              "select" => {
                "name" => "Departnment"
              }
            },
            "Photo" => {
              "files" => [
                {
                  "file" => {
                    "url" => "photo_url"
                  },
                  "name" => "photo_name"
                }
              ]
            },
            "Inactive" => {
              "checkbox" => false
            }
          },
          "archived" => false
        },
        {
          "properties" => {
            "Work Email" => {
              "email" => "email2@email.email"
            },
            "Gender" => {
              "select" => {
                "name" => "Female"
              }
            }
          },
          "archived" => false
        }
      ]
    }
  end

  let(:generated_team_members) { described_class.new.fetch_team_members }

  before do
    allow_any_instance_of(Notion::Client).to receive(:fetch_data)
      .and_return(team_members_data)
  end

  it "gets team members from notion" do
    expect(generated_team_members.count).to eq 2
    expect(generated_team_members.first).to have_attributes(
      email: "email1@email.email",
      full_name: "Full Name",
      department: "Departnment",
      photo: "photo_url",
      avatar_name: "photo_name",
      archived: false,
      gender: "male"
    )
    expect(generated_team_members.last).to have_attributes(
      email: "email2@email.email",
      full_name: nil,
      department: nil,
      photo: nil,
      avatar_name: nil,
      archived: false,
      gender: "female"
    )
  end
end
