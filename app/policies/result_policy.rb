class ResultPolicy < ApplicationPolicy
  def update?
    record.user == user
  end
end
