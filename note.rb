# What I did... Draft 1

# routes.rb
Rails.application.routes.draw do
  resources :items, only: [:index]
  
  resources :users, only: [:index, :show] do
    resources :items, only: [:index]
  end

end


# items_controller
class ItemsController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    items = Item.all
      render json: items, include: :user
  end

  # private

  # def render_not_found_response
  #   render json: { error: "User not found" }, status: :not_found
  # end

end


# users_controller
class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /users/:user_id/items
  def index
    users = User.all
    render json: users, include: :items
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  private

  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end

end
