class Api::V1::TeamsController < ApplicationController
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all # All teams are accessible in scope
    end
  end

  attr_reader :user, :team

  def initialize(user, team)
    @user = user
    @team = team
  end

  def index
    @teams = policy_scope(Team)
    render json: @teams
  end

  # GET /api/v1/teams/:id
  def show
    user.present? #allows current user to view ind. team "present" = logged in
    render json: @team
  end

  # POST /api/v1/teams
  def create
    @team = current_user.teams.new(team_params) #Assign the current user as the team owner
    if @team.save
      render json: @team, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

 

  # PATCH/PUT /api/v1/teams/:id
  def update
    if user.present? && (team.user_id == user.id || user.admin?)
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/teams/:id
  def destroy
    if user.present? && (team.user_id == user.id || user.admin?)
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

end
