class OrdersController < ApplicationController
before_action :set_order, only: [:show, :edit, :update, :reset_status, :edit_order_as_admin]

  def index
    @orders = Order.where(status: 1)
    @myorders = Order.where(user: current_user, status: 1)
  end

  def show
    @user = User.find(@order.user_id)
    @product_orders = @order.product_orders
  end

  def new
  end

  def create
  end

  def edit
    @order.status = 0
    @user = @order.user
    @categories = Category.all
    @product_orders = @order.product_orders
  end

  def update
    if order_params[:status].to_i == 1
      @order.update(order_params)
      @order.save
      redirect_to order_path
    else
      @order.product_orders.destroy_all
      @order.update(order_params)
      @order.save
      redirect_to products_path
    end
  end

  def reset_status
    if (@order.user == current_user && @order.week_number == current_week) || current_user.admin?
      @order.status = 0
      @order.save
      redirect_to products_path
    end
  end

  def edit_order_as_admin
    @order.status = 0
    @order.save
  end


  def destroy
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end

end
