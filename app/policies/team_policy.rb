class TeamPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    # Collection-level authorization (which Teams can a user see?)
    def resolve
      scope.all #all teams are accessible in scope.a;;
    end
  end

  attr_reader :user, :team

  def initialize(user, team)
    @user = user
    @team = team
  end

  def index?
    true #any user can view
  end

  def show?
    user.present?
  end

  def create?
    user.present? && (team.user_id == user.id || user.admin?) #admin and team user can create a team within their list
  end

  def update?
    user.present? && (team.user_id == user.id || user.admin?) #refer to create
  end

  def destroy?
    user.present? && (team.user_id == user.id || user.admin?) #refer to create
  end
 
end
