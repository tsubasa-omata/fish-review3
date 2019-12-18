class FishesController < ApplicationController
  def index
    @q = Fish.ransack(params[:q])
    @fishes = @q.result(distinct: true)
  end

  def show
    @fish = Fish.find_by(id: params[:id])
    @reviews = @fish.reviews
  end

  private
  def search_params
    params.require(:q).permit(:name)
  end

end
