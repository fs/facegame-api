class ReloadQuestions
  class PrepareParams
    include Interactor

    delegate :questions_info, to: :context

    def call
      context.updatable_questions_info = updatable_questions_info
      context.archived_questions_emails = archived_questions_emails
    end

    private

    def updatable_questions_info
      @updatable_questions_info ||= questions_info.select do |item|
        !item.archived &&
          item.email.present? &&
          item.full_name.present? &&
          item.department.present? &&
          item.photo.present?
      end
    end

    def archived_questions_emails
      @archived_questions_emails ||=
        questions_info
          .select { |item| item.archived && item.email.present? }
          .map(&:email)
    end

    def notion_adapter
      Notion::Adapter.new
    end
  end
end
