# frozen_string_literal: true

require "rails_helper"

describe FilteredQuestionsQuery do
  subject(:query) { described_class.new(Question.all, filter_params) }

  let!(:question_1) { create :question }
  let!(:question_2) { create :question }

  let(:filter_params) { {} }

  describe "#all" do
    subject(:all) { query.all }

    it { is_expected.to match_array([question_1, question_2]) }

    context "when param is user_updated" do
      let(:filter_params) { { limit: 1 } }

      it { is_expected.to match_array([question_1]) }
    end
  end
end
