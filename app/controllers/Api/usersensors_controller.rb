module Api
    class UsersensorsController < ApplicationController
        
        #Get all user sensors
        #GET /api/sensors/:id
        def show
            sensor = Sensor.find_by(user_id: params[:id])
            if sensor
                render json: {
                    errorMessage: "",
                    data: sensor
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
