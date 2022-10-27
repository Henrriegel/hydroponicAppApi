class AuthenticationController < ApplicationController
    
    skip_before_action :authenticate_request, only: [:login]
    
    #POST /auth/login
    def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            token = jwt_encode(
                user_id: user.id,
                nickname: user.nickname
            )
            render json: {
                errorMessage: '',
                data: token
            }, status: :ok
        else
            render json: {
                errorMessage: 'Sin acceso',
                data: ''
            }, status: :ok
        end
    end
end