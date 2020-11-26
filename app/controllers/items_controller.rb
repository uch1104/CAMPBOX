class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :order]
  before_action :move_to_index, only: [:edit, :destroy]
  before_action :move_to_session, only: [:new, :order]

  def index
    @user = User.new
    @items = Item.includes(:user).order('created_at DESC').page(params[:page]).per(4)
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

  def show
    @order = Order.new
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def order
    @order = Order.new(order_params)
    redirect_to new_card_path and return unless current_user.card.present?
    redirect_to new_address_path and return unless current_user.address.present?

    if @order.valid?
      pay_item
      @order.save
      @item.save_notification_order(current_user, @order.id, @item.user_id)
      render :done
    else
      render :order
    end
  end

  def done
    @order = Order.find(params[:id])
  end

  def search
    @items = Item.search(params[:keyword]).order('created_at DESC')
  end

  def divide
    @items = Item.where(category_id: params[:category_id]).order('created_at DESC')
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :price, :description, :precaution, :condition_id, :cost_id, :prefecture_id, :shipping_method_id, :category_id, :start_date, :limit_date).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless current_user.id == @item.user_id
  end

  def order_params
    params.require(:order).permit(:rental_start_date, :rental_limit_date).merge(item_id: params[:id], user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price,
      customer: customer_token,
      currency: 'jpy'
    )
  end

  def move_to_session
    redirect_to new_user_session_path unless user_signed_in?
  end
end

