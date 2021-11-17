require "rails_helper"

describe StartGame do
  describe ".organized" do
    subject { described_class.organized }

    let(:expected_interactors) do
      [
        StartGame::CreateResult,
        StartGame::PrepareParams,
        FindRandomQuestion,
        CreateResultAnswer
      ]
    end

    it { is_expected.to eq(expected_interactors) }
  end
end
