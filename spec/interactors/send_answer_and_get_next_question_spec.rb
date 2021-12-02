require "rails_helper"

describe SendAnswerAndGetNextQuestion do
  describe ".organized" do
    subject { described_class.organized }

    let(:expected_interactors) do
      [
        SendAnswerAndGetNextQuestion::PrepareParams,
        SendAnswerAndGetNextQuestion::UpdatePreviousAnswer,
        SendAnswerAndGetNextQuestion::UpdateResultScore,
        SendAnswerAndGetNextQuestion::SetCurrentQuestion,
        SendAnswerAndGetNextQuestion::PrepareQuestionParams,
        SendAnswerAndGetNextQuestion::FindRandomQuestion,
        SendAnswerAndGetNextQuestion::CreateResultAnswer,
        SendAnswerAndGetNextQuestion::SetCorrectAnswersCount
      ]
    end

    it { is_expected.to eq(expected_interactors) }
  end
end
