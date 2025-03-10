class UsersController < ApplicationController
  def create
    if user = User.create(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      role: params[:role]
      )
      #bc of one of the gems
    # if user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

end
