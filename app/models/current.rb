class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :user

  def user
    return nil unless session
    session.user
  end

  def reset
    @session = nil
    @user = nil
  end
end
