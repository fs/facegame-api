class SigninUser
  include Interactor::Organizer

  delegate :user, to: :context

  organize AuthenticateUser,
           CreateAccessToken,
           CreateRefreshToken
end
