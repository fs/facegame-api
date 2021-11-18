require "rails_helper"

describe StartGame::PrepareParams do
  include_context "with interactor"

  let(:initial_context) do
    {
      current_user: current_user
    }
  end
  let(:current_user) { create :user }
  let(:expected_filter_options) { { excluded_email: current_user.email } }

  describe ".call" do
    it_behaves_like "success interactor"

    it "prepares params" do
      interactor.run

      expect(context.filter_options).to eq(expected_filter_options)
    end
  end
end
