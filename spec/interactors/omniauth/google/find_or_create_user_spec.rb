require "rails_helper"
require "google/apis/oauth2_v2"

describe Omniauth::Google::FindOrCreateUser do
  include_context "with interactor"

  let(:initial_context) { { user_info: user_info } }

  let(:user_info) do
    instance_double "Google::Apis::Oauth2V2::Userinfo"
  end

  before do
    allow(user_info).to receive(:given_name).and_return("FirstName")
    allow(user_info).to receive(:family_name).and_return("LastName")
    allow(user_info).to receive(:email).and_return("user@flatstack.com")
    allow(user_info).to receive(:picture).and_return("spec/fixtures/images/avatar.jpg")
  end

  describe ".call" do
    context "when user not exists" do
      it "creates user" do
        interactor.run

        expect(context.user).to have_attributes(
          first_name: "FirstName",
          last_name: "LastName",
          email: "user@flatstack.com"
        )

        expect(context.user.avatar_url).not_to be_nil

        expect(context.user).to be_persisted
      end
    end

    context "when user exists" do
      let!(:user) { create :user, email: "user@flatstack.com", first_name: "Carlee", last_name: "Eleanor" }

      it "creates user" do
        interactor.run

        expect(context.user).to have_attributes(
          first_name: "Carlee",
          last_name: "Eleanor",
          email: "user@flatstack.com"
        )

        expect(context.user).to be_persisted
        expect(context.user).to eq user
      end
    end

    context "when user is invalid" do
      before do
        allow(user_info).to receive(:email).and_return("user@gmail.com")
      end

      let(:error_data) do
        {
          message: { email: ["should have allowed subdomain"] },
          status: 400,
          code: :bad_request
        }
      end

      it_behaves_like "failed interactor"
    end
  end
end
