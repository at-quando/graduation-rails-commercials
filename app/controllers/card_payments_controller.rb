class CardPaymentsController < ApplicationController
  before_action :perform_authorization, only: [:create]

  def create
    order = params[:orders]
    orders = create_order(params)
    auth = Authentication.find_by(uid: request.headers[:uid], provider: request.headers[:provider])
    payment = CardPayment.new(
      first_name: params[:info]['firstname'],
      last_name: params[:info]['lastname'],
      card_type: params[:info]['type'],
      card_number: params[:info]['cardNum'],
      card_verification: params[:info]['cvv'],
      card_expires_on: DateTime.new(params[:info]['expired']['year'].to_i, params[:info]['expired']['month'].to_i),
      order_id: orders.id)
      payment.ip_address = request.remote_ip
      if payment.save
        if payment.purchase(params[:total])
          create_order_items(order, orders)
          ConfirmOrderJob.perform_later(auth, orders.order_items.includes(:product, :property).to_a)
          render json: { status: 'ok' }
        else
          payment.destroy
          orders.destroy
          render json: { status: 'failed' }
        end
      else
        orders.destroy
        render json: { status: 'unvalidated' }
      end
  end

  def index
    @orders = Order.where(user_id: params[:id], status: 2)
    render json: @orders
  end

  def create_order(params)
    current_user.orders.create(
      receiver: params[:receiver]['name'],
      address: params[:receiver]['address'],
      phone: params[:receiver]['phone'],
      total: params[:total]
    )
  end

  def create_order_items(order, orders)
    order.each do |ord|
    orders.order_items.create(
      quantity: ord['quantity'],
      total: ord['quantity'] * Property.find(ord['property']).price,
      property_id: ord['property']
    )
    end
  end
end
