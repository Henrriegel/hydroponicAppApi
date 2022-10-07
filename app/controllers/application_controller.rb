class ApplicationController < ActionController::API
    include JsonWebToken
    before_action :authenticate_request

    private

    def authenticate_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        if !header
            render json: {
                errorMessage: "Not authorized",
                data: "No tienes header"
            }, status: :unprocessable_entity
        else
            decoded = jwt_decode(header)
            current_user = User.find(decoded[:user_id]) rescue nil
            if !current_user
                render json: {
                    errorMessage: "Not authorized",
                    data: "Estás usando un token de un muerto"
                }, status: :unprocessable_entity
            end
        end
    end
end
