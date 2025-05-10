class User < ApplicationRecord
  has_secure_password validations: false
  has_many :sessions, dependent: :destroy
  has_many :jests, dependent: :destroy
  has_many :honks, dependent: :destroy
  has_many :bonks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :honked_jests, through: :honks, source: :jest
  has_many :bonked_jests, through: :bonks, source: :jest

  IDENTITIES = %w[jester buffoon clown joker harlequin mime minstrel fool trickster].freeze
  PROFILE_PICTURES = (1..9).map { |i| "profile_#{i}.png" }.freeze

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :username, length: { minimum: 3, maximum: 30 }
  validates :username, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "can only contain letters, numbers, underscores, and hyphens" }
  validates :profile_picture, presence: true, inclusion: { in: PROFILE_PICTURES }
  validates :identity, presence: true, inclusion: { in: IDENTITIES }
  
  validates :password, presence: true, length: { minimum: 1 }
  validates :password_confirmation, presence: true, if: -> { password.present? }
  validate :password_confirmation_matches, if: -> { password.present? && password_confirmation.present? }

  normalizes :username, with: ->(u) { u.strip }

  def self.authenticate_by(username:, password:)
    find_by(username: username)&.authenticate(password)
  end

  def profile_picture_path
    "/images/profile_pics/#{profile_picture}"
  end

  private

  def password_confirmation_matches
    if password != password_confirmation
      errors.add(:password_confirmation, "doesn't match password")
    end
  end
end
