module Api
    class SensorsController < ApplicationController
        skip_before_action :authenticate_request, only: [:show, :create]

        #GET /api/sensors
        def index
            sensors = Sensor.all.to_json()
            encoded = JWT.encode(sensors, SECRET_KEY)
            render json: {
                errorMessage: "",
                data: encoded.split('.').second
            }, status: :ok
        end
        
        #GET /api/sensors/:id
        def show
            sensor = Sensor.find_by(mac_address: params[:id])
            if sensor
                encoded = JWT.encode(sensor.to_json(), SECRET_KEY)
                render json: {
                    errorMessage: "",
                    idSensor: sensor[:id],
                    data: encoded.split('.').second
                }, status: :ok
            else
                render json: {
                    errorMessage: "Sensor not found",
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        #POST /api/sensors
        def create
            exists = Sensor.find_by(name: sensor_params[:name])
            if !exists 
                sensor = Sensor.new(sensor_params)
                if sensor.save
                    render json: {
                        errorMessage: "",
                        data: "Created"
                    }, status: :ok
                else
                    render json: {
                        errorMessage: sensor.errors,
                        data: ""
                    }, status: :unprocessable_entity
                end
            else
                render json: {
                    errorMessage: "Duplicated name",
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        #DELETE /api/sensors/:id
        def destroy
            sensor = Sensor.find(params[:id])
            if sensor.destroy
                render json: {
                    errorMessage: "",
                    data: "Erased"
                }, status: :ok
            else
                render json: {
                    errorMessage: sensor.errors,
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        private

        def sensor_params
            params.permit(:name, :user_id, :plant_id)
        end
    end
end