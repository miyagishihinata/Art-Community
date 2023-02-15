class Notice < ApplicationRecord
  default_scope -> { order(created_at: :desc) } #作成日時の降順
  belongs_to :illustration, optional: true  #イラスト
  belongs_to :comment,      optional: true  #コメント

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true  #自分からの通知
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true  #相手からの通知
end
