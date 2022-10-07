module Api
    class PlantsController < ApplicationController
        #GET /api/plants
        def index
            plants = Plant.all.to_json()
            encoded = JWT.encode(plants, SECRET_KEY)
            render json: {
                errorMessage: "",
                data: encoded.split('.').second
            }, status: :ok
        end
        
        #GET /api/plants/:id
        def show
            plant = Plant.find(params[:id])
            if plant
                encoded = JWT.encode(plant.to_json(), SECRET_KEY)
                render json: {
                    errorMessage: "",
                    data: encoded.split('.').second
                }, status: :ok
            else
                render json: {
                    errorMessage: "Plant not found",
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        #POST /api/plants
        def create
            plant = Plant.new(plant_params)
            if plant.save
                render json: {
                    errorMessage: "",
                    data: "Created"
                }, status: :ok
            else
                render json: {
                    errorMessage: plant.errors,
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        #DELETE /api/plants/:id
        def destroy
            plant = Plant.find(params[:id])
            if plant.destroy
                render json: {
                    errorMessage: "",
                    data: "Erased"
                }, status: :ok
            else
                render json: {
                    errorMessage: plant.errors,
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        private

        def plant_params
            params.permit(:name)
        end
    end
end