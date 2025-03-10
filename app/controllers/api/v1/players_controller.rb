class PlayersController < ApplicationController
  before_action :set_team

  # GET /api/v1/teams/:team_id/players
  def index
    render json: @team.players #show all players associated with the team
  end

  # POST /api/v1/teams/:team_id/players
  def create
    @player = @team.players.build(player_params) #Build a new player instance associated with the team
    if @player.save
      render json: @player, status: :created
    else
      render json: { errors: @player.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_team
    @team = Team.find(params[:team_id]) # Find the team by ID from the URL
  end
end
