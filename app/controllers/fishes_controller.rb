class FishesController < ApplicationController
  def index
    @q = Fish.ransack(params[:q])
    @fishes = @q.result(distinct: true)
  end

  def show
    @q = Fish.search(search_params)
    @fish = @q.result(distinct: true)
  end

  private
  def search_params
    params.require(:q).permit!
  end

end
