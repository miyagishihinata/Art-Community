class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_picture            #アイコン
  has_many :illustrations, dependent: :destroy #イラスト
  has_many :comments, dependent: :destroy      #コメント
  has_many :likes, dependent: :destroy         #いいね

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # フォロー一覧画面,フォロワー一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  #通知
  has_many :active_notices, class_name: 'Notice', foreign_key: 'visitor_id', dependent: :destroy  #自分からの通知
  has_many :passive_notices, class_name: 'Notice', foreign_key: 'visited_id', dependent: :destroy #相手からの通知

  #検索
  def self.search(keyword)
  where(["user_name like?", "%#{keyword}%"])
  end

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end


  #フォロー通知
  def create_notice_follow!(current_user)
    temp = Notice.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notice = current_user.active_notices.new(
        visited_id: id,
        action: 'follow'
      )
      notice.save if notice.valid?
    end
  end


 #アイコン
  def get_profile_picture(width,height)
    unless profile_picture.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_picture.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_picture.variant(resize_to_limit: [width,height]).processed
  end

 #ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "ゲスト"
    end
  end

end
