class FishesController < ApplicationController
  def index
    @q = Fish.ransack(params[:q])
    @fishes = @q.result(distinct: true)
  end

  def show
    @fish = Fish.find_by(id: params[:id])
    @q = @fish.reviews.ransack(params[:q])
    @reviews = @q.result.includes(:fish).page(params[:page]).per(20)
  end

  

private
    def search_params
      params.require(:q).permit(:name)
    end

end
