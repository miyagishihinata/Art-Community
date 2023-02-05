class CreatePostIllustrations < ActiveRecord::Migration[6.1]
  def change
    create_table :post_illustrations do |t|

      t.timestamps
    end
  end
end
