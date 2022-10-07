module Api
    class ParametersController < ApplicationController
        #GET /api/parameters
        def index
            parameters = Parameter.all.to_json()
            encoded = JWT.encode(parameters, SECRET_KEY)
            render json: {
                errorMessage: "",
                data: encoded.split('.').second
            }, status: :ok
        end
        
        #GET /api/parameters/:user_id
        def show
            parameter = Parameter.find_by(user_id: params[:id])
            if parameter
                encoded = JWT.encode(parameter.to_json(), SECRET_KEY)
                render json: {
                    errorMessage: "",
                    data: encoded.split('.').second
                }, status: :ok
            else
                render json: {
                    errorMessage: "Parameter not found",
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        #POST /api/parameters
        def create
            
            ### Obtener el id del header
            header = request.headers['Authorization']
            header = header.split(' ').last if header
            decoded = jwt_decode(header)
            current_user = User.find(decoded[:user_id])

            exists = Parameter.find_by(plant_id: parameter_params[:plant_id], user_id: current_user)

            if !exists 
                parameter = Parameter.new(parameter_params)
                if parameter.save
                    render json: {
                        errorMessage: "",
                        data: "Created"
                    }, status: :ok
                else
                    render json: {
                        errorMessage: parameter.errors,
                        data: ""
                    }, status: :unprocessable_entity
                end
            else
                render json: {
                    errorMessage: "Duplicated parameter",
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        #DELETE /api/parameters/:id
        def destroy
            parameter = Parameter.find(params[:id])
            if parameter.destroy
                render json: {
                    errorMessage: "",
                    data: "Erased"
                }, status: :ok
            else
                render json: {
                    errorMessage: parameter.errors,
                    data: ""
                }, status: :unprocessable_entity
            end
        end

        private

        def parameter_params
            params.permit(:temperature, :ph, :conductivity, :nutrients, :humidity, :user_id, :plant_id)
        end
    end
end