# frozen_string_literal: true

module Notion
  class TeamMember
    def initialize(data)
      @email = get_email_from_data(data)
      @full_name = get_full_name_from_data(data)
      @department = get_department_from_data(data)
      @photo = get_photo_from_data(data)
      @archived = get_archived_from_data(data)
    end

    attr_reader :email, :full_name, :department, :photo, :archived

    private

    def get_email_from_data(data)
      data["properties"]
        .fetch("Work Email", {})
        .fetch("email", nil)
    end

    def get_full_name_from_data(data)
      data["properties"]
        .fetch("Full name", {})
        .fetch("title", [])
        .fetch(0, {})
        .fetch("plain_text", nil)
    end

    def get_department_from_data(data)
      data["properties"]
        .fetch("Department", {})
        .fetch("select", {})
        .fetch("name", nil)
    end

    def get_photo_from_data(data)
      data["properties"]
        .fetch("Photo", {})
        .fetch("files", [])
        .fetch(0, {})
        .fetch("file", {})
        .fetch("url", nil)
    end

    def get_archived_from_data(data)
      data["archived"]
    end
  end
end
