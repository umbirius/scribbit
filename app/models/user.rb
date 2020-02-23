class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]
  
  validates :username, presence: true
  has_many :projects
  has_many :characters, through: :projects
  has_many :setts, through: :projects
  has_many :scenes, through: :projects
  has_many :posts
  has_many :requested_reviews, foreign_key: :reviewee_id, class_name: "Review"
  has_many :your_reviewers, through: :requested_reviews, source: :reviewer
  has_many :accepted_reviews, foreign_key: :reviewer_id, class_name: "Review"
  


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email 
      user.username = auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
    end
  end  

end
