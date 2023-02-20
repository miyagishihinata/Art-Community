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
    where(["title like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"])
  end

  #いいね通知
  def create_notice_like!(current_user)

    # すでに「いいね」されているか検索
    temp = Notice.where(["visitor_id = ? and visited_id = ? and illustration_id = ? and action = ? ", current_user.id, user_id, id, 'like'])

    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notice = current_user.active_notices.new(
        illustration_id: id,
        visited_id: user_id,
        action: 'like'
      )

      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notice.visitor_id == notice.visited_id
        notice.checked = true
      end
      notice.save if notice.valid?
    end
  end

  #コメント通知
  def create_notice_comment!(current_user, comment_id)

    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(illustration_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notice_comment!(current_user, comment_id, temp_id['user_id'])
    end

    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notice_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notice_comment!(current_user, comment_id, visited_id)

    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notice = current_user.active_notices.new(
      illustration_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notice.visitor_id == notice.visited_id
      notice.checked = true
    end
    notice.save if notice.valid?
  end

end
