require "rails_helper"

describe Types::QueryType do
  include_context "with stubbed activerecord default order", model: Question, order: { id: :asc }

  let!(:user) { create :user, email: "primary@flatstack.com" }
  let(:token_payload) { { type: "access" } }

  let(:query) do
    <<-GRAPHQL
      query {
        images
      }
    GRAPHQL
  end

  let(:question1) { create :question, id: 111 }
  let(:question2) { create :question, id: 222 }
  let(:question3) { create :question, id: 333 }
  let(:image_path) { "spec/fixtures/images/avatar.jpg" }

  before do
    question1.avatar = File.open(Rails.root.join(image_path), "rb")
    question1.avatar_derivatives!
    question1.save

    question2.avatar = File.open(Rails.root.join(image_path), "rb")
    question2.avatar_derivatives!
    question2.save

    question3.avatar = File.open(Rails.root.join(image_path), "rb")
    question3.avatar_derivatives!
    question3.save
  end

  it_behaves_like "graphql request", "returns question image urls" do
    let(:schema_context) { { current_user: user } }
    let(:fixture_path) { "json/acceptance/graphql/query_images.json" }

    let(:prepared_fixture_file) do
      fixture_file.gsub(
        /:url_1|:url_2|:url_3/,
        ":url_1" => question1.avatar(:normal).url,
        ":url_2" => question2.avatar(:normal).url,
        ":url_3" => question3.avatar(:normal).url
      )
    end
  end
end
