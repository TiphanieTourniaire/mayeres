class ProductOrdersController < ApplicationController
  before_action :set_product_order, only: [:update, :destroy]
  before_action :set_order, only: [:create, :destroy, :update]
  before_action :set_products, only: [:create, :update]

  def index
    @years = Order.where(status: 1).group(:year_number).count
  end

  def show
    @year = params[:year_number].to_i
    @weeks = Order.where(status: 1, year_number: @year).group(:week_number).count
  end

  def week
    @year = params[:year_number].to_i
    @week = params[:week_number].to_i
    @categories = Category.all
    @quantities = ProductOrder.joins(:product, :order).where("status = ?", 1).where("year_number = #{@year}").where("week_number = #{@week}").group(:product).sum(:quantity)
  end

  def create
    @categories = Category.all
    save_order unless @order.persisted?
    if product_order_params[:quantity].to_i > 0
      @product_order = @order.product_orders.create(product_order_params)
    end
    session[:order_id] = @order.id
    @product_order.save
    @product_orders = current_order.product_orders
  end

  def destroy
    @product_order.destroy
    redirect_to products_path
  end

  def update
    @categories = Category.all
    if product_order_params[:quantity].to_i == 0
      @product_order.destroy
    else
      @product_order.update(product_order_params)
    end
    @product_orders = current_order.product_orders
  end

  private

  def product_order_params
    params.require(:product_order).permit(:quantity, :product_id)
  end

  def set_products
    if current_user.admin?
      @products = Product.order(active: :desc)
    else
      @products = Product.where(active: true)
    end
  end

  def set_product_order
    @product_order = ProductOrder.find(params[:id])
  end

  def set_order
    @order = current_order
  end

  def save_order
    @order.save
  end
end
