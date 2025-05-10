class Bonk < ApplicationRecord
  belongs_to :user
  belongs_to :bonkable, polymorphic: true, counter_cache: true

  validates :user_id, uniqueness: { scope: [:bonkable_type, :bonkable_id], message: "can only bonk once per item" }
end
