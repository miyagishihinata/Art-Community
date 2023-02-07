class Illustration < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy


  validates :title, presence: true
  validates :image, presence:true

  def get_image(width,height)
    image.variant(resize_to_limit: [width,height]).processed
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

end
