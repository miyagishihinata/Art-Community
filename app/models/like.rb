class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post_illustration
end