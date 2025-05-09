class JestsController < ApplicationController
  before_action :require_authentication
  before_action :set_jest, only: %i[ show ]

  def index
    @jests = Jest.visible_to(Current.user).order(created_at: :desc)
    @jest = Jest.new
  end

  def show
  end

  def create
    @jest = Current.user.jests.build(jest_params)
    
    if @jest.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @jest }
      end
    else
      @jests = Jest.visible_to(Current.user).order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_jest
    @jest = Jest.visible_to(Current.user).find(params[:id])
  end

  def jest_params
    params.require(:jest).permit(:content, :audience)
  end
end
