class Jest < ApplicationRecord
	belongs_to :user
	validates :content, presence: true
	validates :audience, presence: true, inclusion: { in: %w[circus secret] }

	scope :visible_to, ->(user) {
		if user
			where("audience = 'circus' OR (audience = 'secret' AND user_id = ?)", user.id)
		else
			where(audience: "circus")
		end
	}
end
