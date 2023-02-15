class Comment < ApplicationRecord
  belongs_to :user                        #ユーザー
  belongs_to :illustration                #イラスト
  has_many :notices, dependent: :destroy  #通知
end
