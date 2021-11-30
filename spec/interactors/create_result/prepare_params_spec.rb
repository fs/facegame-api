require "rails_helper"

describe CreateResult::PrepareParams do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { current_user: user, params: params } }

  let(:user) { create :user }
  let(:params) do
    {
      answers: [
        {
          question_id: 111,
          value: "Name1"
        },
        {
          question_id: 222,
          value: "Name2"
        },
        {
          question_id: 333,
          value: "Name4"
        }
      ]
    }
  end

  let(:expected_prepared_answers_params) do
    [
      {
        status: "correct", question_id: 111, value: "Name1"
      },
      {
        status: "correct", question_id: 222, value: "Name2"
      },
      {
        status: "incorrect", question_id: 333, value: "Name4"
      }
    ]
  end
  let(:expected_prepared_result_params) do
    {
      user: user,
      score: 133,
      finish_at: current_time
    }
  end

  describe ".call" do
    context "with correct data" do
      before do
        create :question, id: 111, full_name: "Name1"
        create :question, id: 222, full_name: "Name2"
        create :question, id: 333, full_name: "Name3"
      end

      it_behaves_like "success interactor"

      it "prepares data" do
        interactor.run

        expect(context.prepared_answers_params).to eq(expected_prepared_answers_params)
        expect(context.prepared_result_params).to eq(expected_prepared_result_params)
      end
    end

    context "with incorrect question id" do
      before do
        create :question, id: 111, full_name: "Name1"
        create :question, id: 222, full_name: "Name2"
      end

      let(:error_data) do
        {
          message: "One of the questions not found",
          status: 404,
          code: :not_found
        }
      end

      it_behaves_like "failed interactor"
    end
  end
end
