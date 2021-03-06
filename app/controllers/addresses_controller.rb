class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update]

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to address_path(@address.id)
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id)
  end

  def set_address
    @address = Address.find(params[:id])
  end
end
