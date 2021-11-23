class SendAnswerAndGetNextQuestion
  include Interactor::Organizer
  include TransactionalInteractor

  organize SendAnswerAndGetNextQuestion::PrepareParams,
           SendAnswerAndGetNextQuestion::UpdatePreviousAnswer,
           SendAnswerAndGetNextQuestion::UpdateResultScore,
           SendAnswerAndGetNextQuestion::PrepareQuestionParams,
           FindRandomQuestion,
           CreateResultAnswer,
           SendAnswerAndGetNextQuestion::SetCorrectAnswersCount
end
