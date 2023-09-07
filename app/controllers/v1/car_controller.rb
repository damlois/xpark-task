class Api::V1::CarController < ApplicationController 
    def index
      where = {}

      if params[:name]
          where["name"] = params[:name]
      end

      if(params)
        cars = Car.where(where)
      else
        cars = Car.all
      end
      
      if cars
        render json: {status: "SUCCESS", message: "Fetched cars successfully", data: cars}, status: :ok
      else
        render json: cars.errors, status: :bad_request
      end
    end

    def create
      car = Car.new(car_params)
    
      if car.save
        render json: {status: "SUCCESS", message: "Car was created successfully!", data: car}, status: :created
      else
        render json: car.errors, status: :unprocessable_entity
      end
    end

    def show
      car = Car.find(params[:id])

      if car
        render json: {data: car}, state: :ok
      else
        render json: {message: "Car does not exist"}, status: :bad_request
      end
    end

    def destroy
      car = Car.find(params[:id])

      if car.destroy!
        render json: {message: "Car was deleted successfully"}, status: :ok
      else
        render json: {message: "Car does not exist"}, status: :bad_request
      end
    end

    def update
      car = Car.find(params[:id])

      if(!car)
        render json: {message: "Car does not exist"}, status: :bad_request
      end

      if car.update!(car_update_params)
        render json: {message: "Car was updated successfully", data: car}, status: :ok
      else
        render json: {message: "Car cannot be updated"}, status: :unprocessable_entity
      end
    end

    private
    def car_params
      params.require(:car).permit(:name, :currentState)
    end

    def car_update_params
      params.require(:car).permit(:currentState)
    end
end