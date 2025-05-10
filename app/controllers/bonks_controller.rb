class BonksController < ApplicationController
  before_action :require_authentication
  before_action :set_bonkable

  def create
    if @bonkable.bonked_by?(current_user)
      @bonk = @bonkable.bonks.find_by!(user_id: current_user.id)
      @bonk.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to redirect_path, notice: "Bonk removed!" }
      end
    else
      @bonk = @bonkable.bonks.build(user_id: current_user.id)
      if @bonk.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to redirect_path, notice: "Bonk added!" }
        end
      else
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace("bonk_error", partial: "shared/error", locals: { error: @bonk.errors.full_messages.join(", ") }) }
          format.html { redirect_to redirect_path, alert: @bonk.errors.full_messages.join(", ") }
        end
      end
    end
  end

  private

  def set_bonkable
    if params[:comment_id]
      @bonkable = Comment.find(params[:comment_id])
    else
      @bonkable = Jest.find(params[:jest_id])
    end
  end

  def redirect_path
    if params[:comment_id]
      jest_path(@bonkable.jest)
    else
      jest_path(@bonkable)
    end
  end
end 