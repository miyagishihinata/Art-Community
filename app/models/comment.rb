class Comment < ApplicationRecord

  belongs_to :user                        #ユーザー
  belongs_to :illustration                #イラスト
  has_many :notices, dependent: :destroy  #通知

  belongs_to :parent,  class_name: "Comment", optional: true
  has_many   :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :post_comment, presence: true, length: { in: 1..150 }

  # ゲストユーザーの判別
  def guest?
    email == 'guest@example.com'
  end

end