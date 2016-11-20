class ItemsController < ApplicationController
  # before_action :authenticate_user!, only: [:create, :update, :destroy]
  skip_before_filter  :verify_authenticity_token

  def create
    @item = Item.create(item_params)
    @list = List.find_by(id: @item.list_id)
    # redirect_to list_path(@item.list_id)
    render json: @list
  end

  def update
    set_item
    @item.update(item_params)
    # redirect_to item_path(@item)
    render json: @item
  end

  def show
    set_item
    render json: @item
  end

  def index
    @items = Item.all
    render json: @items
  end

  def destroy
    set_item
    @item.destroy
    redirect_to items_path
  end

  private
  def set_item
    @item = Item.find_by(id: params[:id])
  end

  def item_params
    params.require(:items).permit(:id, :name, :url, :purchaser_id, :list_id)
  end
end
