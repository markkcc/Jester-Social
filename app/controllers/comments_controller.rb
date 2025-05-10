class CommentsController < ApplicationController
  before_action :require_authentication
  before_action :set_jest
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @jest.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @jest, notice: "Comment added!" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("comment_error", partial: "shared/error", locals: { error: @comment.errors.full_messages.join(", ") }) }
        format.html { redirect_to @jest, alert: @comment.errors.full_messages.join(", ") }
      end
    end
  end

  def destroy
    @comment.destroy if @comment.user == current_user

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @jest, notice: "Comment removed!" }
    end
  end

  private

  def set_jest
    @jest = Jest.find(params[:jest_id])
  end

  def set_comment
    @comment = @jest.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end 