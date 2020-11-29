class FavoritesController < ApplicationController
  before_action :set_item

  def create
    favorite = current_user.favorites.build(item_id: params[:item_id])
    favorite.save
  end

  def destroy
    favorite = Favorite.find_by(item_id: params[:item_id], user_id: current_user.id)
    favorite.destroy
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

end
