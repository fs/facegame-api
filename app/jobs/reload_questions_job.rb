class ReloadQuestionsJob < ApplicationJob
  queue_as :recursive

  def perform
    ReloadQuestions.call
  end
end
