class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id,         null: false
      t.integer :illustration_id, null: false
      t.text    :post_comment,    null: false
      t.timestamps
    end
  end
end
