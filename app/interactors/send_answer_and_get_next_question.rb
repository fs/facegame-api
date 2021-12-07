class SendAnswerAndGetNextQuestion
  include Interactor::Organizer
  include TransactionalInteractor

  organize SendAnswerAndGetNextQuestion::PrepareParams,
           SendAnswerAndGetNextQuestion::UpdatePreviousAnswer,
           SendAnswerAndGetNextQuestion::UpdateResultScore,
           SendAnswerAndGetNextQuestion::SetCurrentQuestion,
           SendAnswerAndGetNextQuestion::PrepareQuestionParams,
           SendAnswerAndGetNextQuestion::FindRandomQuestion,
           SendAnswerAndGetNextQuestion::CreateResultAnswer,
           SendAnswerAndGetNextQuestion::SetCorrectAnswersCount
end
