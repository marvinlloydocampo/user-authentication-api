class UsersController < ApplicationController
  # TO DO add authentication of API Endpoint
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all.to_a
    render json: @users.map(&:attributes), status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user.attributes, status: :ok
  end

  # POST /users
  def create
    @user = User.create(user_params)
    render json: @user.attributes, status: :created
    rescue StandardError => e
      render json: { errors: e }, status: :unprocessable_entity
  end

  # PUT /users/{username}
  def update
    @user.update(user_params)
    render json: @user.attributes, status: :ok
    rescue StandardError => e 
      render json: { errors: e }, status: :unprocessable_entity
  end

  # DELETE /users/{username}
  def destroy
    @user.delete
  end

  private

  def find_user
    @user = User.find(username: params[:_username]).first
    if @user.nil?
      render json: { errors: 'User not found' }, status: :not_found
    end
  end

  def user_params
    params.permit(
      :username, :password, :password_confirmation
    )
  end
end
