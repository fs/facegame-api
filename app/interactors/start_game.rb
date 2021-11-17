class StartGame
  include Interactor::Organizer
  include TransactionalInteractor

  organize StartGame::CreateResult,
           StartGame::PrepareParams,
           FindRandomQuestion,
           CreateResultAnswer
end
