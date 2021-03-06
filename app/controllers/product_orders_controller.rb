class ProductOrdersController < ApplicationController
  before_action :set_product_order, only: [:update, :destroy]
  before_action :set_order, only: [:create, :destroy, :update]
  before_action :set_products, only: [:create, :update]

  def create
    @categories = Category.order(id: :asc)
    if product_order_params[:quantity].to_f > 0
      @product_order = @order.product_orders.create(product_order_params)
    end
    @product_order.save
    @product_orders = current_order.product_orders
    @post = Post.last
  end

  def destroy
    @product_order.destroy
    redirect_to products_path
  end

  def update
    @categories = Category.order(id: :asc)
    if product_order_params[:quantity].to_f == 0
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
    @products = Product.where(active: true)
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
