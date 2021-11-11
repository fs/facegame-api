class AuthenticateByGoogleAuthCode
  include Interactor::Organizer

  organize Omniauth::Google::BuildAuthClient,
           Omniauth::Google::ExchangeAuthCode,
           Omniauth::Google::FetchUserInfo,
           Omniauth::Google::CheckEmailUniqness,
           Omniauth::Google::FindOrCreateUser
end
