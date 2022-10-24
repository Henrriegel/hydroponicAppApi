module Api
    class LecturesController < ApplicationController
        skip_before_action :authenticate_request, only: [:create]
        
        #GET /api/lectures/:id  - Obtener la ultima lectura de una esp32 (:id es el id del esp32)
        def show
            lecture = Lecture.where(sensor_id: params[:id]).order('id').last()
            if lecture
                render json: {
                    errorMessage: "",
                    data: lecture
                }, status: :ok
            else
                render json: {
                    errorMessage: "No hay lecturas",
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        #POST /api/lectures
        def create
            lecture = Lecture.new(lecture_params)
            if lecture.save
                render json: {
                    errorMessage: "",
                    data: "Created"
                }, status: :ok
            else
                render json: {
                    errorMessage: lecture.errors,
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        #DELETE /api/lectures/:id
        def destroy
            lecture = Lecture.find(params[:id])
            if lecture.destroy
                render json: {
                    errorMessage: "",
                    data: "Erased"
                }, status: :ok
            else
                render json: {
                    errorMessage: lecture.errors,
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        private

        def lecture_params
            params.permit(:roomTemperature, :temperature1, :temperature2, :ph, :roomHumidity, :sensor_id)
        end
    end
end