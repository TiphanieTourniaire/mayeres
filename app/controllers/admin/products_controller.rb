module Admin
  class ProductsController < Admin::ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy, :toggle_active]
    skip_before_action :verify_authenticity_token, only: :activate_for

    def index
      @categories = Category.order(id: :asc)
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)

      if @product.subcategory.present? && @product.subcategory.category != @product.category
        flash[:alert] = "Attention, la catégorie et sous-catégorie doivent correspondre"
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
      @categories = Category.order(id: :asc)
      @product.active = !@product.active
      @product.save
    end

    def deactivate_for
      @category = Category.find(params[:id])
      Product.deactivate_for(@category)
      redirect_to admin_products_path
    end

    def activate_for
      @category = Category.find(params[:id])
      Product.activate_for(@category)
      redirect_to admin_products_path
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
