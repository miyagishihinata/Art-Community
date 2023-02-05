class PostIllustration < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :image, presence:true

  def get_image

      image
  end

  def liked_by?(user)
    lokes.exists?(user_id: user.id)
  end

end
