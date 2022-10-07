module Api
    class LecturesController < ApplicationController
        #GET /api/lectures
        def index
            lectures = Lecture.all.to_json()
            encoded = JWT.encode(lectures, SECRET_KEY)
            render json: {
                errorMessage: "",
                data: encoded.split('.').second
            }, status: :ok
        end
        
        #GET /api/lectures/:id
        def show
            lecture = Lecture.find(params[:id])
            if lecture
                encoded = JWT.encode(lecture.to_json(), SECRET_KEY)
                render json: {
                    errorMessage: "",
                    data: encoded.split('.').second
                }, status: :ok
            else
                render json: {
                    errorMessage: "Lecture not found",
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        #POST /api/lectures/:mac_address
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
            params.permit(:temperature, :ph, :conductivity, :nutrients, :humidity, :sensor_id)
        end
    end
end