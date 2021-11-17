require "rails_helper"

describe StartGame::CreateResult do
  include_context "with interactor"
 
    let(:initial_context) do
      {
        result: result,
        result_params: result_params
      }
    end

    let(:result) { create :result, id: 1 }

    let(:result_params) do
      {
        user: current_user,
        finished_at: 45
      }
    end
    
    let(:current_user)

  describe ".call"
  it_behaves_like "success interactor"

    it "provides generated refresh token" do
      interactor.run

      expect(context.result).to eq(create_result)
    end
end