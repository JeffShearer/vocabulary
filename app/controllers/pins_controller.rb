class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

# This shows the list of pins (read all)
  def index
    @pins = Pin.all
  end

# This shows the pin
  def show
  end

# This is the create pin page
  def new
    @pin = current_user.pins.build
  end

  def edit
  end

#This is the actual pin resource being created
  def create
     @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'  
    else
      render :new 
    end
  end

# This is the pin edit page
  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render :edit 
    end
  end

# This destroys the pin
  def destroy
    @pin.destroy
      redirect_to pins_url
  end

  private

    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end

    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
