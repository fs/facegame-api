class ReloadQuestions
  include Interactor::Organizer
  include TransactionalInteractor

  organize ReloadQuestions::FetchQuestionsInfo,
           ReloadQuestions::PrepareParams,
           ReloadQuestions::DeleteArchivedQuestions,
           ReloadQuestions::CreateOrUpdateQuestions
end
