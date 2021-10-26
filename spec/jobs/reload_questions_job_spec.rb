require "rails_helper"

describe ReloadQuestionsJob do
  it "calls interactor to create reload questions" do
    expect(ReloadQuestions).to receive(:call!)

    described_class.perform_now
  end
end
