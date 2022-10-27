module Api
    class PasswordsController < ApplicationController

        # UPDATE api/passwords/:id
        def update
            user = User.find(params[:id]) rescue nil
            if user
                if user.authenticate(password_edit_params[:password_old])
                    user.password = password_edit_params[:password]
                    if user.save
                        render json: {
                            errorMessage: "",
                            data: "Updated"
                        }, status: :ok
                    else
                        render json: {
                            errorMessage: user.errors,
                            data: ""
                        }, status: :ok
                    end
                else
                    render json: {
                        errorMessage: "Contraseña incorrecta",
                        data: ""
                    }, status: :ok
                end
            else
                render json: {
                    errorMessage: "User not found",
                    data: ""
                }, status: :ok
            end
        end

        private

        def password_edit_params
            params.permit(:password, :password_old)
        end
    end
end