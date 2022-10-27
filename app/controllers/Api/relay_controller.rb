module Api
    class RelayController < ApplicationController

        #GET /api/relay/:id                                         Returns sensor_id and activated state
        def show
            sensor = Sensor.find_by(mac_address: params[:id])
            if sensor
                render json: {
                    errorMessage: "",
                    idSensor: sensor[:id],
                    activate: sensor[:activate]
                }, status: :ok
            else
                render json: {
                    errorMessage: "Sensor not found",
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        # PUT api/sensor/:mac_address
        def update
            sensor = Sensor.find_by(mac_address: params[:id])
            if sensor
                if sensor.update(sensor_params)
                    render json: {
                        errorMessage: "",
                        data: "Updated"
                    }, status: :ok
                else
                    render json: {
                        errorMessage: sensor.errors,
                        data: ""
                    }, status: :unprocessable_entity
                end
            else
                render json: {
                    errorMessage: "Sensor not found",
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        private

        def sensor_params
            params.permit(:activate)
        end
    end
end