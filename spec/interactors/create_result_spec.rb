require "rails_helper"

describe CreateResult do
  describe ".organized" do
    subject { described_class.organized }

    let(:expected_interactors) do
      [
        CreateResult::PrepareParams,
        CreateResult::SaveModel,
        CreateResult::CreateAnswers
      ]
    end

    it { is_expected.to eq(expected_interactors) }
  end
end
