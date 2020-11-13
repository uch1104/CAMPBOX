class ItemsController < ApplicationController
  def index
    @user = User.new
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :price, :description, :precaution, :condition_id, :cost_id, :prefecture_id, :shipping_method_id, :start_date, :limit_date).merge(user_id: current_user.id)
  end
end
