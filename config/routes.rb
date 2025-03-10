Rails.application.routes.draw do
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] #user can only create 
      
      resources :teams do 
        resources :players, only: [:index, :create] #nested routes for players within teams...
      end
    end
  end
  # SHOW TEAMS GET /api/v1/teams/:id
  # CREATE TEAMS POST /api/v1/teams
  # UPDATE TEAMS PATCH/PUT /api/v1/teams/:id
  # DELETE  TEAMS /api/v1/teams/:id

  # SHOW PLAYERS GET /api/v1/teams/:team_id/players
  # CREATE TEAMS POST /api/v1/teams/:team_id/players

end
