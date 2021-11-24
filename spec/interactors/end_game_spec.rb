require "rails_helper"

describe EndGame do
  describe ".organized" do
    subject { described_class.organized }

    let(:expected_interactors) do
      [
        EndGame::PrepareParams,
        EndGame::UpdateResult
      ]
    end

    it { is_expected.to eq(expected_interactors) }
  end
end
