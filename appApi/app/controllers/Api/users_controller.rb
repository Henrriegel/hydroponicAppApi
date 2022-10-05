module Api
    class UsersController < ApplicationController

        #GET /users
        def index
            users = User.order('id').to_json()
            encoded = JWT.encode(users, Rails.application.secrets.secret_key_base)
            render json: {
                errorMessage: "",
                data: encoded.split('.').second
            }, status: :ok
        end
        
        #GET /users/:id
        def show
            user = User.find(params[:id])
            if user
                encoded = JWT.encode(user.to_json(), Rails.application.secrets.secret_key_base)
                render json: {
                    errorMessage: "",
                    data: encoded.split('.').second
                }, status: :ok
            else
                render json: {
                    errorMessage: "User not found",
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        #POST /users
        def create
            user = User.new(user_params)
            if user.save
                render json: {
                    errorMessage: "",
                    data: user
                }, status: :ok
            else
                render json: {
                    errorMessage: user.errors,
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        #DELETE /users/:id
        def destroy
            if user.destroy
                render json: {
                    errorMessage: "",
                    data: user
                }, status: :ok
            else
                render json: {
                    errorMessage: user.errors,
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        private

        def set_user
            user = User.find(params[:id])
        end

        def user_params
            params.require(:user).permit(:nickname, :email, :password)
        end
    end
end