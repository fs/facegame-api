class CreateResult
  include Interactor::Organizer
  include TransactionalInteractor

  organize CreateResult::PrepareParams,
           CreateResult::SaveModel,
           CreateResult::CreateAnswers,
           CreateResult::UpdateUserScore
end
