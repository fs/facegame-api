require "rails_helper"
require "google/apis/oauth2_v2"

describe Omniauth::Google::CheckEmailUniqness do
  include_context "with interactor"

  let(:initial_context) { { user_info: user_info } }

  let(:user_info) do
    instance_double "Google::Apis::Oauth2V2::Userinfo"
  end

  before do
    allow(user_info).to receive(:email).and_return("user@flatstack.com")
  end

  describe ".call" do
    context "when user doesn`t exists" do
      it_behaves_like "success interactor"
    end

    context "when user exists" do
      let(:error_data) do
        {
          message: "You already have another account",
          status: 400,
          code: :bad_request
        }
      end

      before do
        create :user, email: "user@scalewill.com"
      end

      it_behaves_like "failed interactor"
    end
  end
end


  