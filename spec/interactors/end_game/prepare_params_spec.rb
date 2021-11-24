require "rails_helper"

describe EndGame::PrepareParams do
  include_context "with interactor"

  let(:initial_context) do
    {
      current_user: current_user,
      game_id: result.id
    }
  end
  let(:current_user) { create :user }
  let!(:result) { create :result, id: 111, finish_at: 10.minutes.since, user: current_user }

  describe ".call" do
    it_behaves_like "success interactor"

    it "prepares params" do
      interactor.run

      expect(context.result).to eq(result)
    end
  end
end
