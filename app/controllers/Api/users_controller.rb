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

            ### Obtener el id del header
            header = request.headers['Authorization']
            header = header.split(' ').last if header
            decoded = jwt_decode(header)
            current_user = User.find(decoded[:user_id])

            ### Ver si el mismo usuario es quien está borrando su cuenta
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

        def update
            user = User.find(params[:id]) rescue nil
            if user
                if user.update(user_params)
                    render json: {
                        errorMessage: "",
                        data: "Updated"
                    }, status: :ok
                else
                    render json: {
                        errorMessage: user.errors,
                        data: ""
                    }, status: :unprocessable_entity
                end
            else
                render json: {
                    errorMessage: "User not found",
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        private

        def user_params
            if params[:password].present?
                params.permit(:nickname, :email, :password)
            else
                params.permit(:nickname, :email)
            end
        end
    end
end