class Public::IllustrationsController < ApplicationController
  def new
    @illustration = Illustration.new
  end

  def create
    @illustration = Illustration.new(item_params)
    @illustration.save
    redirect_to illustration_path(@illustration.id)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item.id)
  end

  private

  def illustration_params
    params.require(:illustration).permit(:title, :introduction, :image)
  end

end
