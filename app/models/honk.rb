class Honk < ApplicationRecord
  belongs_to :user
  belongs_to :honkable, polymorphic: true, counter_cache: true

  validates :user_id, uniqueness: { scope: [:honkable_type, :honkable_id], message: "can only honk once per item" }
end
