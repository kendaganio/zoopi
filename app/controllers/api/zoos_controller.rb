class Api::ZoosController < ApplicationController

  def index
    render json: Zoo.all
  end

  def show
    zoo = Zoo.find(params[:id])
    render json: zoo
  end

  def update
    zoo = Zoo.find params[:id]
    zoo.update_attributes(zoo_params)
    render json: zoo
  end

  def destroy
    zoo = Zoo.find params[:id]
    render json: zoo.destroy
  end

  def zoo_params
    params.require(:zoo).permit(:name)
  end
end
