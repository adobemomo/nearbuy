# frozen_string_literal: true

class GoodsController < ApplicationController
  before_action :find_good, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create delete update destroy]

  def index
    on_home_page = params[:clear] == 'clear' || !params[:sort].nil?
    sort = on_home_page ? params[:sort] : session[:sort]
    if session[:sort] != params[:sort]
      session[:sort] = sort
      redirect_to goods_path(sort: sort)
    end

    latitude = params[:latitude]
    longitude = params[:longitude]

    @goods = Goods.all_goods.order(sort)

    goods_map = nil
    if !latitude.nil? && !longitude.nil?
      goods_map = Goods.explore_goods(latitude, longitude, sort)
      @goods = goods_map['goods']
    end

    puts '----------------------------------------'
    @goods.each do |good|
      puts good.name
    end
    puts '----------------------------------------'

    # @hash = Gmaps4rails.build_markers(@goods) do |good, marker|
    #   marker.lat good.latitude
    #   marker.lng good.longitude
    #   marker.infowindow render_to_string(partial: "/goods/map_box", locals: { good: good })
    # end

    @hash = if !latitude.nil? && !longitude.nil?
              Gmaps4rails.build_markers(@goods) do |good, marker|
                goods_map[good]['lats'].length.each do |i|
                  marker.lat goods_map[good]['lats'][i]
                  marker.lng goods_map[good]['longs'][i]
                  marker.infowindow render_to_string(partial: "/goods/map_box", locals: { good: good })
                end
              end
            else
              Gmaps4rails.build_markers(@goods) do |good, marker|
                if !good.latitude.nil? && !good.longitude.nil?
                  marker.lat good.latitude
                  marker.lng good.longitude
                  marker.infowindow render_to_string(partial: "/goods/map_box", locals: { good: good })
                end
                if !good.latitude1.nil? && !good.longitude1.nil?
                  marker.lat good.latitude1
                  marker.lng good.longitude1
                  marker.infowindow render_to_string(partial: "/goods/map_box", locals: { good: good })
                end
                if !good.latitude2.nil? && !good.longitude2.nil?
                  marker.lat good.latitude2
                  marker.lng good.longitude2
                  marker.infowindow render_to_string(partial: "/goods/map_box", locals: { good: good })
                end
              end
            end

  end

  def show; end

  def new
    @good = Goods.new
  end

  def create
    goods_param = goods_params
    goods_param[:user_name] = current_user.username

    @good = Goods.new(goods_param)

    if @good.save
      redirect_to user_goods_list_path, notice: "#{@good.name} was successfully created."
    else
      render action: 'new'
    end
  end

  def edit; end

  # def delete
  #   @good = Goods.find(params[:id])
  # end

  def update
    if @good.update(goods_params)
      redirect_to user_goods_list_path, notice: 'Goods was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # def destroy
  #   if @good.destroy
  #     respond_destroy_success
  #   else
  #     respond_destroy_fail
  #   end
  # end

  private

  def find_good
    @good = Goods.find(params[:id])
  end

  def goods_params
    params.require(:goods).permit(:name, :address)
  end

  # def respond_destroy_success
  #   respond_to do |format|
  #     format.html { redirect_to goods_url }
  #     format.json { head :no_content }
  #   end
  # end
  #
  # def respond_destroy_fail
  #   respond_to do |format|
  #     format.html { redirect_to goods_url }
  #     format.json { head :forbidden }
  #   end
  # end

end
