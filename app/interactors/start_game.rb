class StartGame
  include Interactor::Organizer
  include TransactionalInteractor

  organize StartGame::CreateResult,
           StartGame::PrepareParams,
           StartGame::FindQuestions,
           StartGame::CreateResultAnswers
end
