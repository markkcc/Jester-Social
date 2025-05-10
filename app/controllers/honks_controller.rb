class HonksController < ApplicationController
  before_action :require_authentication
  before_action :set_honkable

  def create
    if @honkable.honked_by?(current_user)
      @honk = @honkable.honks.find_by!(user_id: current_user.id)
      @honk.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to redirect_path, notice: "Honk removed!" }
      end
    else
      @honk = @honkable.honks.build(user_id: current_user.id)
      if @honk.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to redirect_path, notice: "Honk added!" }
        end
      else
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace("honk_error", partial: "shared/error", locals: { error: @honk.errors.full_messages.join(", ") }) }
          format.html { redirect_to redirect_path, alert: @honk.errors.full_messages.join(", ") }
        end
      end
    end
  end

  private

  def set_honkable
    if params[:comment_id]
      @honkable = Comment.find(params[:comment_id])
    else
      @honkable = Jest.find(params[:jest_id])
    end
  end

  def redirect_path
    if params[:comment_id]
      jest_path(@honkable.jest)
    else
      jest_path(@honkable)
    end
  end
end 