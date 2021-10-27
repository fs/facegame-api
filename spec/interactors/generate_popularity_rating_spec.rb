require "rails_helper"

describe GeneratePopularityRating do
  include_context "with interactor"

  let(:initial_context) { { current_user: user } }

  let(:user) { create :user, email: email }
  let(:question) { create :question, email: "email@flatstack.com" }
  let(:email) { "email@flatstack.com" }

  let(:expected_data) do
    {
      answers_count: 3,
      correct_answers_count: 2
    }
  end

  before do
    create :answer, question: question, correct: true
    create :answer, question: question, correct: true
    create :answer, question: question, correct: false
    create :answer, question: question, correct: true, created_at: 8.days.ago
    create :answer, correct: true
    create :answer, correct: false
  end

  describe ".call" do
    it_behaves_like "success interactor"

    it "creates popularity rating" do
      interactor.run

      expect(context.data).to eq expected_data
    end
  end

  context "with second email" do
    let(:email) { "email@scalewill.com" }

    it_behaves_like "success interactor"

    it "creates popularity rating" do
      interactor.run

      expect(context.data).to eq expected_data
    end
  end
end
