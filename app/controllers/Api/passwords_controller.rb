module Api
    class PasswordsController < ApplicationController

        # UPDATE api/passwords/:id
        def update
            user = User.find(params[:id]) rescue nil
            if user
                if user.authenticate(password_edit_params[:password_old])
                    if user.update_attribute(password_edit_params[:password])
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
                        errorMessage: "Contraseña incorrecta",
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

        def password_edit_params
            params.permit(:password, :password_old)
        end
    end
end