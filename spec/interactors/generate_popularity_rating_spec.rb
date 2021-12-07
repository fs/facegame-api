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

    before do
      create :answer, question: question, status: "correct"
      create :answer, question: question, status: "incorrect"
      create :answer, question: question, status: "pending", value: nil
      create :answer, question: question, status: "correct", created_at: 8.days.ago
      create :answer, status: "correct"
      create :answer, status: "incorrect"
    end

    context "with only one correct answer" do
      let(:expected_data) do
        {
          statistic: "1 of 3 time",
          avatar_url: nil
        }
      end

      let!(:answer) { create :answer, question: question, status: "incorrect" }

      describe ".call" do
        it_behaves_like "success interactor"

        it "creates popularity rating" do
          interactor.run

          expect(context.data).to eq expected_data
        end
      end
    end

    context "with more than one correct answer" do
      let(:expected_data) do
        {
          statistic: "2 of 3 times",
          avatar_url: nil
        }
      end

      let!(:answer) { create :answer, question: question, status: "correct" }

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
end
