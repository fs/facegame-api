require "rails_helper"

describe ReloadQuestionsJob do
  it "calls interactor to create reload questions" do
    expect(ReloadQuestions).to receive(:call!).with(provider: "notion")

    described_class.perform_now
  end
end
