class FishesController < ApplicationController
  def index
    @fishes = Fish.all
  end

  def show
    @fish = Fish.find_by(id: params[:id])
  end
end
