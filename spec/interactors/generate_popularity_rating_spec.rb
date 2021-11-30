require "rails_helper"

describe GeneratePopularityRating do
  include_context "with interactor"

  let(:initial_context) { { current_user: user } }

  let(:user) { create :user, email: email }

  let(:email) { "email@flatstack.com" }

  context "when question doesn`t exist" do
    it_behaves_like "success interactor"

    it "creates popularity rating" do
      interactor.run

      expect(context.data).to eq nil
    end
  end

  context "when question exists" do
    let(:question) { create :question, email: "email@flatstack.com" }

    let(:expected_data) do
      {
        answers_count: 3,
        correct_answers_count: 2,
        avatar_url: nil
      }
    end

    before do
      create :answer, question: question, status: "correct"
      create :answer, question: question, status: "correct"
      create :answer, question: question, status: "incorrect"
      create :answer, question: question, status: "incorrect", value: nil
      create :answer, question: question, status: "correct", created_at: 8.days.ago
      create :answer, status: "correct"
      create :answer, status: "incorrect"
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
end
