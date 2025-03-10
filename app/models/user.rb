class User < ApplicationRecord
  has_many :teams
  has_secure_password
  validates :email, presence: true, uniqueness: true

  validates :role, inclusion: { in: %w[user admin], message: "%{value} is not a valid role" }

  def admin? #? true or false
    role == 'admin'
  end

  def user?
    role == 'user'
  end
end
