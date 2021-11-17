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
  let!(:question) { create :question }

  describe ".call" do
    it_behaves_like "success interactor"

    it "finds random question" do
      interactor.run

      expect(context.question).to be_present
      expect(context.question).to eq(question)
    end
  end
end
