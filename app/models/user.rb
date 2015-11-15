class User < ActiveRecord::Base
  has_secure_password
  has_many  :user_saved_chords
  has_many  :user_songs
  has_many  :songs, through: :user_songs
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
