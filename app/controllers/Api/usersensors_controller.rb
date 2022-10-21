module Api
    class UsersensorsController < ApplicationController
        
        #Get all user sensors
        #GET /api/sensors/:id
        def show
            sensor = Sensor.find_by(user_id: params[:id])
            if sensor
                encoded = JWT.encode(sensor.to_json(), SECRET_KEY)
                render json: {
                    errorMessage: "",
                    data: encoded.split('.').second
                }, status: :ok
            else
                render json: {
                    errorMessage: "User has no sensors",
                    data: ""
                }, status: :unprocessable_entity
            end
        end
    end
end
