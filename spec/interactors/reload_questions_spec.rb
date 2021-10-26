require "rails_helper"

describe ReloadQuestions do
  describe ".organized" do
    subject { described_class.organized }

    let(:expected_interactors) do
      [
        ReloadQuestions::FetchQuestionsInfo,
        ReloadQuestions::PrepareParams,
        ReloadQuestions::DeleteArchivedQuestions,
        ReloadQuestions::CreateOrUpdateQuestions
      ]
    end

    it { is_expected.to eq(expected_interactors) }
  end
end
