require "rails_helper"
require "google/apis/oauth2_v2"

describe Omniauth::Google::FindOrCreateUser do
  subject(:context) { described_class.call(user_info: user_info) }

  let(:user_info) do
    instance_double "Google::Apis::Oauth2V2::Userinfo"
  end

  before do
    allow(user_info).to receive(:given_name).and_return("FirstName")
    allow(user_info).to receive(:family_name).and_return("LastName")
    allow(user_info).to receive(:email).and_return("user@example.com")
  end

  describe ".call" do
    context "when user not exists" do
      it "creates user" do
        expect(context.user).to have_attributes(
          first_name: "FirstName",
          last_name: "LastName",
          email: "user@example.com"
        )

        expect(context.user).to be_persisted
      end
    end

    context "when user exists" do
      let!(:user) { create :user, email: "user@example.com", first_name: "Carlee", last_name: "Eleanor" }

      it "creates user" do
        expect(context.user).to have_attributes(
          first_name: "Carlee",
          last_name: "Eleanor",
          email: "user@example.com"
        )

        expect(context.user).to be_persisted
        expect(context.user).to eq user
      end
    end
  end
end
