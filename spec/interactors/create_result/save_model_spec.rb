require "rails_helper"

describe CreateResult::SaveModel do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { prepared_result_params: prepared_result_params } }

  let(:prepared_result_params) do
    {
      user: user,
      score: 133
    }
  end

  let(:user) { create :user }
  let(:created_result) { Result.last }

  describe ".call" do
    it_behaves_like "success interactor"

    it "creates result" do
      interactor.run

      expect(created_result).not_to be_nil
      expect(created_result).to have_attributes(prepared_result_params)
    end
  end
end
