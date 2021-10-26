module Omniauth
  module Google
    class FindOrCreateUser
      include Interactor

      delegate :user_info, :user, to: :context
      delegate :email, :family_name, :given_name, :picture, to: :user_info

      def call
        context.user = user
        context.fail!(error_data: invalid_user_error) unless user.valid?
      end

      private

      def user
        @user ||= User.find_or_create_by(email: email) do |user|
          user.first_name = given_name
          user.last_name = family_name
          user.password = SecureRandom.hex(20)
          user.avatar = URI.open(picture)
        end
      end

      def invalid_user_error
        { message: "Email should have allowed subdomain", status: 400, code: :bad_request }
      end
    end
  end
end
