class Session < ApplicationRecord
  belongs_to :user

  scope :active, -> { where('created_at > ?', 24.hours.ago) }

  def self.cleanup_old_sessions
    where('created_at <= ?', 24.hours.ago).destroy_all
  end
end
