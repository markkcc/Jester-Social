class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :jest

  has_many :honks, as: :honkable, dependent: :destroy
  has_many :bonks, as: :bonkable, dependent: :destroy
  has_many :honking_users, through: :honks, source: :user
  has_many :bonking_users, through: :bonks, source: :user

  validates :content, presence: true, length: { maximum: 1440 }

  def honked_by?(user)
    honking_users.include?(user)
  end

  def bonked_by?(user)
    bonking_users.include?(user)
  end
end
