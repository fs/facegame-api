class EndGame
  include Interactor::Organizer
  include TransactionalInteractor

  organize EndGame::PrepareParams,
           EndGame::UpdateResult
end
