module Api
    class UsersController < ApplicationController
        skip_before_action :authenticate_request, only: [:create]

        #GET /users
        def index
            users = User.all.to_json()
            encoded = JWT.encode(users, SECRET_KEY)
            render json: {
                errorMessage: "",
                data: encoded.split('.').second
            }, status: :ok
        end
        
        #GET /users/:id
        def show
            user = User.find(params[:id])
            if user
                encoded = JWT.encode(user.to_json(), SECRET_KEY)
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
                    data: "Created"
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
            user = User.find(params[:id])
            if current_user[:user_id] == user[:user_id]
                if user.destroy
                    render json: {
                        errorMessage: "",
                        data: "Erased"
                    }, status: :ok
                else
                    render json: {
                        errorMessage: user.errors,
                        data: ""
                    }, status: :unprocessable_entity
                end
            end
        end

        private

        def user_params
            params.require(:users).permit(:nickname, :email, :password)
        end
    end
end