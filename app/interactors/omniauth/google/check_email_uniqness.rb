require "google/apis/oauth2_v2"

module Omniauth
  module Google
    class CheckEmailUniqness
      include Interactor

      delegate :user_info, to: :context
      delegate :email, to: :user_info

      def call
        context.fail!(error_data: invalid_email_error) if user_exists?
      end

      private

      def user_exists?
        User.where("email LIKE ? AND email != ?", prepared_email_query, email).exists?
      end
    
      def prepared_email_query
        "#{email.split('@')[0]}%"
      end

      def invalid_email_error
        { message: "You already have another account", status: 400, code: :bad_request }
      end
    end
  end
end
