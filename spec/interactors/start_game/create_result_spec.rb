require "rails_helper"

describe StartGame::CreateResult do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) do
    {
      current_user: current_user
    }
  end

  let(:current_user) { create :user }
  let(:created_result) { Result.last }

  describe ".call" do
    it_behaves_like "success interactor"

    it "creates result" do
      interactor.run

      expect(context.result).to be_present
      expect(context.result).to eq(created_result)
      expect(created_result).to have_attributes(
        user: current_user,
        finish_at: 55.seconds.since
      )
    end
  end
end
