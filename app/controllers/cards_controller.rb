class CardsController < ApplicationController
  def new
    @address = current_user.address
  end

  def create
    Payjp.api_key = Rails.application.credentials.PAYJP['PAYJP_SECRET_KEY']
    customer = Payjp::Customer.create(
      description: 'test',
      card: params[:card_token]
    )

    card = Card.new(
      card_token: params[:card_token],
      customer_token: customer.id,
      user_id: current_user.id
    )
    if card.save
      redirect_to user_path(current_user.id)
    else
      redirect_to 'new'
    end
  end

  def show
    Payjp.api_key = Rails.application.credentials.PAYJP['PAYJP_SECRET_KEY']
    card = Card.find_by(user_id: current_user)

    redirect_to new_card_path and return unless card.present?

    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
    @address = current_user.address
  end

end
