class ApplicationController < ActionController::API
    include JsonWebToken
    before_action :authenticate_request

    private

    def authenticate_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        decoded = jwt_decode(header)
        current_user = User.find(decoded[:user_id]) rescue nil
        if !current_user || !header
            render json: {
                errorMessage: "Not authorized",
                data: ""
            }, status: :ok
        end
    end
end
