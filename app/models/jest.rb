class Jest < ApplicationRecord
	belongs_to :user
	has_many :honks, as: :honkable, dependent: :destroy
	has_many :bonks, as: :bonkable, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :honking_users, through: :honks, source: :user
	has_many :bonking_users, through: :bonks, source: :user

	validates :content, presence: true
	validates :audience, presence: true, inclusion: { in: %w[circus secret] }

	scope :visible_to, ->(user) {
		if user
			where("audience = 'circus' OR (audience = 'secret' AND user_id = ?)", user.id)
		else
			where(audience: "circus")
		end
	}

	def honked_by?(user)
		honking_users.include?(user)
	end

	def bonked_by?(user)
		bonking_users.include?(user)
	end
end
