class Illustration < ApplicationRecord
  has_one_attached :image

  belongs_to :user                        #ユーザー
  has_many :comments, dependent: :destroy #コメント
  has_many :likes, dependent: :destroy    #いいね
  has_many :notices, dependent: :destroy  #通知


  validates :title, presence: true #イラストタイトル
  validates :image, presence:true  #イラスト

  #イラスト
  def get_image(width,height)
    image.variant(resize_to_limit: [width,height]).processed
  end

  #いいね
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  #検索
  def self.search(keyword)
    where(["title like? ", "%#{keyword}%"])
  end

end
