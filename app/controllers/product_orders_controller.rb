class ProductOrdersController < ApplicationController
# before_action :set_product_order, only: [:show, :edit, :update, :destroy]
# before_action :set_order, only [:create, :destroy]

  def new
    @product_order = ProductOrder.new
    authorize @product_order
  end

  def create
    # @product_order = current_user.product_orders.build(product_order_params)
    @order = current_order
    @item = @order.product_orders.new(item_params)
    @order.save
    session[:order_id] = @order.id
    redirect_to products_path
    # authorize @product_order
  end

  def destroy
    @order = current_order
    @item = @order.product_orders.find(params[:id])
    @item.destroy
    @order.save
    redirect_to cart_path
  end


  def edit
  end

  def update
  end

  private

  def item_params
    params.require(:product_order).permit(:quantity, :product_id)
  end

  def set_product_order
    @product_order = ProductOrder.find(params[:id])
    authorize @product_order
  end
end
