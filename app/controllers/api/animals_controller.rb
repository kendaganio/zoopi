class Api::AnimalsController < ApplicationController

  def index
    animals =
      if params[:filters]
        Animal.joins(:tags).where(tags: {value: params[:filters]}).uniq
      else
        Animal.all
      end

    render json: animals
  end

  def show
    aminal = Animal.find params[:id]
    render json: aminal
  end

  def update
    aminal = Animal.find params[:id]
    aminal.update_attributes(animal_params)
    render json: aminal
  end

  def destroy
    aminal = Animal.find params[:id]
    render json: aminal.destroy
  end

  def animal_params
    params.require(:animal).permit(:name)
  end


end
