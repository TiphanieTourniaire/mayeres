class ProductOrdersController < ApplicationController
  before_action :set_product_order, only: [:update, :destroy]
  before_action :set_order, only: [:create, :destroy, :update]

  def index
    @product_orders = ProductOrder.all
    @products = Product.first(Product.count)
    @users = User.order(:first_name).all
    @test = ProductOrder.group(:product_id).count
    @test2 = ProductOrder.joins(:products)
  end

  def new
    @product_order = ProductOrder.new
  end

  def create
    if product_order_params[:quantity].to_i > 0
      @order.product_orders.new(product_order_params)
      @order.save
    end
    session[:order_id] = @order.id
    redirect_to products_path
  end

  def destroy
    @product_order.destroy
    @order.save
    redirect_to products_path
  end

  def update
    if product_order_params[:quantity].to_i == 0
      @product_order.destroy
      @order.save
    else
      @product_order.update(product_order_params)
      @order.save
    end
    redirect_to products_path
  end

  private

  def product_order_params
    params.require(:product_order).permit(:quantity, :product_id)
  end

  def set_product_order
    @product_order = ProductOrder.find(params[:id])
  end

  def set_order
    @order = current_order
  end
end
