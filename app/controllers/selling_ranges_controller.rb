class SellingRangesController < ApplicationController
  before_action :set_selling_range, only: [:edit, :update, :destroy]

  def new
    @selling_range = SellingRange.new
  end

  def create
    @selling_range = SellingRange.new(selling_range_params)
    if @selling_range.save
      redirect_to selling_ranges_path
    else
      render :create
    end
  end

  def destroy
    @selling_range.destroy
    redirect_to selling_ranges_path
  end

  def edit
  end

  def update
    @selling_range.update(selling_range_params)
    if @selling_range.save
      redirect_to selling_ranges_path
    else
      render :update
    end
  end

  def index
    @selling_ranges = SellingRange.all
  end

  private

  def set_selling_range
    @selling_range = SellingRange.find(params[:id])
  end

  def selling_range_params
    params.require(:selling_range).permit(:starts_at, :ends_at)
  end
end
