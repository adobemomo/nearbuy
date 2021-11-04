# frozen_string_literal: true

class GoodsController < ApplicationController
  before_action :find_good, only: %i[show edit update destroy]

  def index
    @goods = Goods.all_goods

    @hash = Gmaps4rails.build_markers(@goods) do |good, marker|
      marker.lat good.latitude
      marker.lng good.longitude
      marker.infowindow render_to_string(partial: "/goods/map_box", locals: { good: good })
    end
  end

  def show; end

  def new
    @good = Goods.new
  end

  def create
    @good = Goods.new(goods_params)

    if @good.save
      redirect_to goods_path, notice: "#{@good.name} was successfully created."
    else
      render action: 'new'
    end
  end

  def edit; end

  def delete
    @good = Goods.find(params[:id])
  end

  def update
    if @good.update(goods_params)
      redirect_to @good, notice: 'Goods was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    if @good.destroy
      respond_destroy_success
    else
      respond_destroy_fail
    end
  end

  private

  def find_good
    @good = Goods.find(params[:id])
  end

  def goods_params
    params.require(:goods).permit(:name, :address)
  end

  def respond_destroy_success
    respond_to do |format|
      format.html { redirect_to goods_url }
      format.json { head :no_content }
    end
  end

  def respond_destroy_fail
    respond_to do |format|
      format.html { redirect_to goods_url }
      format.json { head :forbidden }
    end
  end

end
