class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :illustration_id
      t.integer :comment_id
      t.string :action,      default: '',    null: false
      t.boolean :checked,    default: false, null: false

      t.timestamps
    end
    
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :illustration_id
    add_index :notifications, :comment_id
  
  end
end
