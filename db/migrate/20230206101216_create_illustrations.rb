class CreateIllustrations < ActiveRecord::Migration[6.1]
  def change
    create_table :illustrations do |t|
      t.integer :user_id, null: false
      t.string  :title, null: false
      t.text    :introduction

      t.timestamps
    end
  end
end
