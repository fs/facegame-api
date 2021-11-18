require "rails_helper"

describe FindRandomQuestion do
  include_context "with interactor"

  let(:initial_context) do
    {
      filter_options: filter_options
    }
  end

  let(:current_user) { create :user }
  let(:filter_options) { { excluded_email: current_user.email } }
  let!(:question1) { create :question }
  let!(:question2) { create :question }
  let!(:question3) { create :question }

  before do
    srand(777)
  end

  describe ".call" do
    it_behaves_like "success interactor"

    it "finds random question" do
      interactor.run

      expect(context.question).to be_present
      expect(context.question).to eq(question3)
    end
  end
end
