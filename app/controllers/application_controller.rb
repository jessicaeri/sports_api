class ApplicationController < ActionController::API
  require 'pundit'
  require 'jwt'
  
  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
      @current_user = User.find(decoded['user_id'])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      render json: { errors: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  # before_action :authorize_request #protect controller actions
      #IF ACTIVATED MUST BE ADMIN TO SEE

  include Pundit
  # Rescue from Pundit errors
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action.'}, status: :forbidden
  end
end
