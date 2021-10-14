require "rails_helper"

describe CreateResult::UpdateUserScore do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { result: result, current_user: user } }

  let(:user) { create :user }
  let(:result) { create :result, user: user, score: 1000 }

  describe ".call" do
    it_behaves_like "success interactor"

    it "updates user score" do
      expect(user.last_score).to eq 0

      interactor.run

      expect(user.last_score).to eq 1000
    end
  end
end
