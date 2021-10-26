# frozen_string_literal: true

module Notion
  class TeamMember
    def initialize(args = {})
      @email = args[:email]
      @full_name = args[:full_name]
      @department = args[:department]
      @photo = args[:photo]
      @avatar_name = args[:avatar_name]
      @archived = args[:archived]
    end

    attr_reader :email, :full_name, :department, :photo, :archived, :avatar_name
  end
end
