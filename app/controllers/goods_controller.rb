# frozen_string_literal: true

class GoodsController < ApplicationController
  before_action :find_good, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create delete update destroy]

  def index
    on_home_page = params[:clear] == 'clear' || !params[:sort].nil?
    explore_mode = !params[:latitude].nil? && !params[:longitude].nil?
    sort = on_home_page ? params[:sort] : session[:sort]
    if session[:sort] != params[:sort] && !explore_mode
      session[:sort] = sort
      redirect_to goods_path(sort: sort)
    end

    latitude = params[:latitude]
    longitude = params[:longitude]

    if params[:sort].nil?
      @goods = Goods.all_goods
    elsif params[:sort] == 'update_time'
      @goods = Goods.all_goods.order(update_time: :desc)
    elsif params[:sort] == 'name'
      @goods = Goods.all_goods.order("lower(name)")
    end

    goods_map = nil
    if !latitude.nil? && !longitude.nil?
      goods_map = Goods.explore_goods(latitude, longitude, sort)
      @goods = goods_map[:goods]
    end

    # @hash = Gmaps4rails.build_markers(@goods) do |good, marker|
    #   marker.lat good.latitude
    #   marker.lng good.longitude
    #   marker.infowindow render_to_string(partial: "/goods/map_box", locals: { good: good })
    # end

    @hash = if !latitude.nil? && !longitude.nil?
              Gmaps4rails.build_markers(@goods) do |good, marker|
                (0..goods_map[good.id][:lats].length-1).each do |i|
                  marker.lat goods_map[good.id][:lats][i]
                  marker.lng goods_map[good.id][:longs][i]
                  marker.infowindow render_to_string(partial: "/goods/map_box", locals: { good: good })
                end
              end
            else
              Gmaps4rails.build_markers(@goods) do |good, marker|
                marker.lat good.latitude
                marker.lng good.longitude
                marker.infowindow render_to_string(partial: "/goods/map_box", locals: { good: good })
              end
            end
  end

  def show; end

  def new
    @good = Goods.new
  end

  def create
    address1 = goods_params[:address1]
    address2 = goods_params[:address2]

    goods_param = goods_params
    goods_param[:user_name] = current_user.username
    if address1 != nil
      goods_param[:latitude1], goods_param[:longitude1] = Geocoder.coordinates(address1)
    end

    if address2 != nil
      goods_param[:latitude2], goods_param[:longitude2] = Geocoder.coordinates(address2)
    end

    @good = Goods.new(goods_param)

    if @good.save
      redirect_to user_goods_list_path, notice: "#{@good.name} was successfully created."
    else
      render action: 'new'
    end
  end

  def edit
    puts 'edit'
    puts 'goods params:' + params.to_s
  end

  # def delete
  #   @good = Goods.find(params[:id])
  # end

  def update
    goods_param = goods_params
    if goods_param[:address1] != "" and goods_param[:address1] != @good.address1
      goods_param[:latitude1], goods_param[:longitude1] = Geocoder.coordinates(goods_param[:address1])
    end

    if goods_param[:address2] != "" and goods_param[:address2] != @good.address2
      goods_param[:latitude2], goods_param[:longitude2] = Geocoder.coordinates(goods_param[:address2])
    end

    if @good.update(goods_param)
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
    params.require(:goods).permit(:name, :address, :address1, :address2)
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
