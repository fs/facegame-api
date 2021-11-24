require "rails_helper"

describe EndGame::UpdateResult do
  include_context "when time is frozen"
  include_context "with interactor"

  let(:initial_context) do
    {
      result: result
    }
  end
  let(:result) { create :result, finish_at: 10.minutes.since }
  let(:result_params) { { finish_at: Time.current } }

  describe ".call" do
    
    it_behaves_like "success interactor"

    it "update previous answer" do
      interactor.run

      expect(result).to have_attributes(
        finish_at: Time.current,
      )
    end
  end
end
