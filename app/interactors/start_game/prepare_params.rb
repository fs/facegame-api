class StartGame
  class PrepareParams
    include Interactor

    delegate :current_user, to: :context

    def call
      context.filter_options = filter_options
    end

    private

    def filter_options
      {
        excluded_email: current_user.email
      }
    end
  end
end
