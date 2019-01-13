class ProductsController < ApplicationController
before_action :set_product, only: [:show, :edit, :update, :destroy, :change_active]

  def index
    if current_user == nil
      redirect_to new_user_session_path
    elsif current_user.admin?
      @products = Product.order(active: :desc, category: :asc)
    else
      @products = Product.where(active: true)
    end
    @product_order = current_order.product_orders.new
    @product_orders = current_order.product_orders
    @order = current_order
    @incart = false
    @product = Product.new
  end

  def show
  end

  def new
  end

  def create
    @product = Product.new(product_params)
    @product.step = [@product.step].to_yaml
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def change_active
    @product.active = !@product.active
    @product.save
    redirect_to products_path
  end

  def edit
  end

  def update
    @product.update(product_params)
    redirect_to products_path
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :unit, :category, :description, :active, :photo)
  end

  def set_product
    @product = Product.find(params[:id])
    # authorize @product
  end

end
