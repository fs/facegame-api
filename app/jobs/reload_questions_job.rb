class ReloadQuestionsJob < ApplicationJob
  queue_as :recursive

  def perform
    ReloadQuestions.call!(provider: provider)
  end

  private

  def provider
    ENV.fetch("RELOAD_QUESTIONS_PROVIDER", "notion")
  end
end
