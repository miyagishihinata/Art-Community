class CreatePostLlustrations < ActiveRecord::Migration[6.1]
  def change
    create_table :post_llustrations do |t|

      t.timestamps
    end
  end
end
