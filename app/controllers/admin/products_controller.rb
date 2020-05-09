module Admin
  class ProductsController < Admin::ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy, :toggle_active]

    def index
      @categories = Category.order(id: :asc)
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)

      if @product.subcategory.present? && @product.subcategory.category != @product.category
        render :new
      elsif @product.save
          redirect_to admin_products_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      @product.assign_attributes(product_params)
      if @product.subcategory.present? && @product.subcategory.category != @product.category
        render :edit
      elsif @product.update(product_params)
          redirect_to admin_products_path
      else
        render :edit
      end
    end

    def toggle_active
      @product.active = !@product.active
      @product.save
      redirect_to admin_products_path
    end

    def active_category
      @category = Category.find(params[:category_id])
      @products = @category.products
      @products.each do |product|
        product.active = true
        product.save
      end
    end

    def destroy
      @product.destroy
      redirect_to admin_products_path
    end

    private

    def product_params
      params.require(:product).permit(:name, :price, :unit, :category_id, :description, :active, :photo, :subcategory_id)
    end

    def set_product
      @product = Product.find(params[:id])
    end
  end
end
