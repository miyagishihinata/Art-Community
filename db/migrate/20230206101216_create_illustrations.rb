class CreateIllustrations < ActiveRecord::Migration[6.1]
  def change
    create_table :illustrations do |t|
      t.string  :title, null: false
      t.text    :introduction

      t.timestamps
    end
  end
end
